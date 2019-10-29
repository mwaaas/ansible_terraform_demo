env=development
config=$(env)
workspace=$(env)
no_deps :=  $(shell [ $(config) = development ] && echo "" || echo --no-deps)
autoApprove := $(shell [ $(config) = development ] && echo "-auto-approve" || echo )

ifeq ($(config), production)
workspace=default
endif

.EXPORT_ALL_VARIABLES:
ENV_FILE=$(config)

ANSIBLE_PLAYBOOK_DEPLOY = docker-compose run $(no_deps) --rm \
							dev_tools ansible-playbook deploy.yml \
							-e "ENV=$(env)" -e "CONFIG=$(config)" \
							$(ansible_env)

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
	rm -r -f ./devops/terraform/terraform.tfstate.d/dev_ansible_terraform_demo/
	# start containers required
	docker-compose up -d dynamodb-local-mock-unsupported-api dynamodb-ui sns_simulator

	$(MAKE) build_app_image
	# force create to use new containes
	# i.e clean copy without anyting installed sns or sqs and tables
	docker-compose up -d --force-recreate localaws dynamodb


ansible_playbooks:
ifdef tags
	$(ANSIBLE_PLAYBOOK_DEPLOY) -t $(tags)
else
	$(ANSIBLE_PLAYBOOK_DEPLOY)
endif


create_sqs_file_if_does_not_exist:
	mkdir -p ./devops/templates/build/envs
	if [ ! -f ./devops/templates/build/envs/sqs_env.env ]; then \
         touch ./devops/templates/build/envs/sqs_env.env; \
     fi
	if [ ! -f ./devops/templates/build/envs/external_services.env ]; then \
		  touch ./devops/templates/build/envs/external_services.env; \
	  fi

deploy: create_sqs_file_if_does_not_exist
	@if [ $(config) = "development" ]; then\
        $(MAKE) dev_setup;\
    fi
	$(MAKE) ansible_playbooks
	$(MAKE) up_app


destroy:
	docker-compose run $(no_deps) dev_tools bash -c "cd terraform && terraform workspace new $(workspace) | true && terraform workspace select $(workspace) && terraform workspace show && terraform init && terraform destroy -input=false -var-file=terraform_values/$(config).tfvars $(autoApprove)"

list_queues:
	 aws --endpoint-url=http://localhost:4576 sqs list-queues

list_topics:
	aws --endpoint-url=http://localhost:4575 sns list-topics

list_subscriptions:
	aws --endpoint-url=http://localhost:4575 sns list-subscriptions

list_tables:
	aws --endpoint-url=http://localhost:3307 dynamodb list-tables