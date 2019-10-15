package com.example.demo

import com.amazon.sqs.javamessaging.message.SQSTextMessage
import org.springframework.jms.annotation.JmsListener
import org.springframework.stereotype.Component

@Component
class Listeners {

    @JmsListener(destination = "\${sqs.foo}")
    fun fooListener(jsonEvent: SQSTextMessage) {

    }

    @JmsListener(destination = "\${sqs.bar}")
    fun barListener(jsonEvent: SQSTextMessage) {

    }
}