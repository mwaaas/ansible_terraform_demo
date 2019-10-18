package com.example.demo.config

import com.amazonaws.services.dynamodbv2.AmazonDynamoDB
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapperConfig
import com.amazonaws.services.dynamodbv2.document.DynamoDB
import org.socialsignin.spring.data.dynamodb.repository.config.EnableDynamoDBRepositories
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import com.amazonaws.client.builder.AwsClientBuilder
import com.example.demo.EventMessageRepository

@Configuration
@EnableDynamoDBRepositories(basePackageClasses = [EventMessageRepository::class])
class DynamoDbConfig(
        @param:Value("\${cloud.aws.useLocalAws}") private val useLocalAws: Boolean,
        @param:Value("\${cloud.aws.dynamodb.endpoint}") private val amazonDynamoDBEndpoint: String,
        @param:Value("\${cloud.aws.region}") private val awsRegion: String
) {


    @Bean
    fun amazonDynamoDB(): AmazonDynamoDB {
        return when (useLocalAws) {
            true -> AmazonDynamoDBClientBuilder
                    .standard()
                    .withEndpointConfiguration(
                            AwsClientBuilder.EndpointConfiguration(amazonDynamoDBEndpoint, awsRegion)
                    ).build()
            false -> AmazonDynamoDBClientBuilder.defaultClient()
        }
    }

    @Bean
    fun dynamoDBMapperConfig(): DynamoDBMapperConfig {
        return DynamoDBMapperConfig.Builder().build()
    }
}