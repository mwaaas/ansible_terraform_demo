package com.example.demo.config

import com.amazon.sqs.javamessaging.ProviderConfiguration
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.jms.annotation.EnableJms
import org.springframework.jms.config.DefaultJmsListenerContainerFactory
import com.amazon.sqs.javamessaging.SQSConnectionFactory
import com.amazonaws.client.builder.AwsClientBuilder
import com.amazonaws.regions.Region
import com.amazonaws.regions.Regions
import com.amazonaws.services.sqs.AmazonSQSAsync
import com.amazonaws.services.sqs.AmazonSQSAsyncClientBuilder
import com.fasterxml.jackson.annotation.JsonInclude
import com.fasterxml.jackson.databind.util.StdDateFormat
import org.springframework.beans.factory.annotation.Value
import org.springframework.jms.core.JmsTemplate
import org.springframework.jms.support.converter.MappingJackson2MessageConverter
import org.springframework.jms.support.converter.MessageConverter
import org.springframework.jms.support.converter.MessageType
import org.springframework.jms.support.destination.DynamicDestinationResolver
import javax.jms.Session
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder


@Configuration
@EnableJms
class SqsConfig(
        @param:Value("\${cloud.aws.useLocalAws}") private val useLocalAws: Boolean,
        @param:Value("\${cloud.aws.region}") private val awsRegion: String,
        @param:Value("\${cloud.aws.sqs.endpoint}") private val endpoint: String,
        @param:Value("\${sqs.concurrency}") private val concurrency: String
){

    private val connectionFactory: SQSConnectionFactory;

    init {
        var sqsClient = createAmazonSQSClient()
        val providerConfiguration = ProviderConfiguration()
        providerConfiguration.numberOfMessagesToPrefetch = 10
        connectionFactory = SQSConnectionFactory(providerConfiguration, sqsClient)
    }


    private fun createAmazonSQSClient(): AmazonSQSAsync {
        return if (this.useLocalAws) {
            val region = Region.getRegion(Regions.fromName(awsRegion))
            val endpointConfiguration = AwsClientBuilder.EndpointConfiguration(
                    endpoint, region.name)
            AmazonSQSAsyncClientBuilder.standard().withEndpointConfiguration(endpointConfiguration).build()
        } else {
            AmazonSQSAsyncClientBuilder.standard().withRegion(awsRegion).build()
        }
    }

    @Bean
    fun jmsListenerContainerFactory(): DefaultJmsListenerContainerFactory {
        val factory = DefaultJmsListenerContainerFactory()
        factory.setConnectionFactory(this.connectionFactory)
        factory.setDestinationResolver(DynamicDestinationResolver())
        factory.setConcurrency(this.concurrency)
        factory.setSessionAcknowledgeMode(Session.CLIENT_ACKNOWLEDGE)
        return factory
    }

    @Bean
    fun sqsJmsTemplate(): JmsTemplate {
        val jmsTemplate = JmsTemplate(this.connectionFactory)
        jmsTemplate.messageConverter = messageConverter()
        return jmsTemplate
    }

    @Bean
    fun messageConverter(): MessageConverter {
        val builder = Jackson2ObjectMapperBuilder()
        builder.serializationInclusion(JsonInclude.Include.NON_EMPTY)
        builder.dateFormat(StdDateFormat())
        val mappingJackson2MessageConverter = MappingJackson2MessageConverter()
        mappingJackson2MessageConverter.setObjectMapper(builder.build())
        mappingJackson2MessageConverter.setTargetType(MessageType.TEXT)
        mappingJackson2MessageConverter.setTypeIdPropertyName("documentType")
        return mappingJackson2MessageConverter
    }
}
