package com.example.demo.config

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapperConfig


class DynamoDbTableNameResolver : DynamoDBMapperConfig.DefaultTableNameResolver() {


    override fun getTableName(clazz: Class<*>?, config: DynamoDBMapperConfig?): String {
        val rawTableName = super.getTableName(clazz, config)
        return System.getenv(rawTableName)
    }
}