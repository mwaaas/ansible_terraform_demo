package com.example.demo

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBAttribute
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBHashKey
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBTable

@DynamoDBTable(tableName = "EVENT_TABLE_NAME")
class EventMessageEntity {

    @DynamoDBHashKey
    var id: String? = null

    @DynamoDBAttribute(attributeName = "message")
    var message: String? = null
}