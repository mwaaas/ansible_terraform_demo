package com.example.demo

import com.amazon.sqs.javamessaging.message.SQSTextMessage
import org.springframework.jms.annotation.JmsListener
import org.springframework.stereotype.Component
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import java.util.*

@Component
class Listeners {

    private val logger = LoggerFactory.getLogger(this.javaClass)

    @Autowired
    private lateinit var eventMessageRepository: EventMessageRepository

    fun saveSqsMessage(sqsMessage: SQSTextMessage){

        eventMessageRepository.save(EventMessageEntity().apply {
            id = UUID.randomUUID().toString()
            message = sqsMessage.text
        })
    }

    @JmsListener(destination = "\${sqs.foo}")
    fun fooListener(sqsTextMessage: SQSTextMessage) {
        logger.info("sqs foo received and event:", sqsTextMessage)
        saveSqsMessage(sqsTextMessage)
    }

    @JmsListener(destination = "\${sqs.bar}")
    fun barListener(sqsTextMessage: SQSTextMessage) {
        logger.info("sqs bar received and event:", sqsTextMessage)
        saveSqsMessage(sqsTextMessage)
    }
}