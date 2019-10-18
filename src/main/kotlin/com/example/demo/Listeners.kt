package com.example.demo

import com.amazon.sqs.javamessaging.message.SQSTextMessage
import org.springframework.jms.annotation.JmsListener
import org.springframework.stereotype.Component
import org.slf4j.LoggerFactory

@Component
class Listeners {

    private val logger = LoggerFactory.getLogger(this.javaClass)

    @JmsListener(destination = "\${sqs.foo}")
    fun fooListener(jsonEvent: SQSTextMessage) {
        logger.info("sqs foo received and event:", jsonEvent)
    }

    @JmsListener(destination = "\${sqs.bar}")
    fun barListener(jsonEvent: SQSTextMessage) {
        logger.info("sqs bar received and event:", jsonEvent)
    }
}