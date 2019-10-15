list_queues:
	 aws --endpoint-url=http://localhost:4100 sqs list-queues

list_topics:
	aws --endpoint-url=http://localhost:4100 sns list-topics

list_subscriptions:
	aws --endpoint-url=http://localhost:4100 sns list-subscriptions

list_tables:
	aws --endpoint-url=http://localhost:4100 dynamodb list-tables