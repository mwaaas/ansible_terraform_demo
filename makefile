env=development
no_deps :=  $(shell [ $(env) = development ] && echo "" || echo --no-deps)
autoApprove := $(shell [ $(env) = development ] && echo "-auto-approve" || echo )

.EXPORT_ALL_VARIABLES:
ENV_FILE=$(env)


build_up: build_app_image up_app

up_app:
	docker-compose up --force-recreate app

build_app_image:
	# build app container since docker compose build does not support
	# https://github.com/moby/buildkit
	# https://github.com/moby/buildkit/issues/685
	docker buildx build  --progress=auto -f Dockerfile  -t ansible_terraform_demo_app --build-arg JAVA_OPTS="-Xgcpolicy:optthrouput -Xquickstart -Xsharedclasses:name=mvn -DargLine=-Xsharedclasses:none -Xshare:off -Xverify:none" --build-arg MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1 -noverify" .

dev_setup:
	# delete state files in development
	rm -f ./devops/$(env)/terraform.tfstate ./devops/$(env)/terraform.tfstate.backup
	# start containers required
	docker-compose up -d dynamodb-local-mock-unsupported-api dynamodb-ui sns_simulator

	$(MAKE) build_app_image
	# force create to use new containes
	# i.e clean copy without anyting installed sns or sqs and tables
	docker-compose up -d --force-recreate localaws dynamodb

terraform:
	docker-compose run $(no_deps) dev_tools bash -c "cd $(env) && terragrunt apply -input=false $(autoApprove)"

deploy:
	@if [ $(env) = "development" ]; then\
        $(MAKE) dev_setup;\
    fi
	$(MAKE) terraform
	$(MAKE) up_app

destroy:
	docker-compose run $(no_deps) dev_tools bash -c "cd $(env) && terragrunt destroy -input=false $(autoApprove)"

list_queues:
	 aws --endpoint-url=http://localhost:4576 sqs list-queues

list_topics:
	aws --endpoint-url=http://localhost:4575 sns list-topics

list_subscriptions:
	aws --endpoint-url=http://localhost:4575 sns list-subscriptions

list_tables:
	aws --endpoint-url=http://localhost:3307 dynamodb list-tables