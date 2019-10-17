env=development
no_deps :=  $(shell [ $(env) = development ] && echo "" || echo --no-deps)
autoApprove := $(shell [ $(env) = development ] && echo "-auto-approve" || echo )

dev_setup:
	# delete state files in development
	rm -f ./devops/terraform/terraform.tfstate ./devops/terraform/terraform.tfstate.backup
	# start containers required
	docker-compose up -d dynamodb_local_mock_unsupported_api dynamodb-ui

	# force create to use new containes
	# i.e clean copy without anyting installed sns or sqs and tables
	docker-compose up -d --force-recreate localaws dynamodb

deploy:
	@if [ $(env) = "development" ]; then\
        $(MAKE) dev_setup;\
    fi
	docker-compose run $(no_deps) dev_tools bash -c "cd terraform && terraform init && terraform apply -input=false -var-file=$(env).tfvars $(autoApprove)"

list_queues:
	 aws --endpoint-url=http://localhost:4576 sqs list-queues

list_topics:
	aws --endpoint-url=http://localhost:4575 sns list-topics

list_subscriptions:
	aws --endpoint-url=http://localhost:4575 sns list-subscriptions

list_tables:
	aws --endpoint-url=http://localhost:3307 dynamodb list-tables