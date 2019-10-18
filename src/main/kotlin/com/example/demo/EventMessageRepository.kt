package com.example.demo

import org.socialsignin.spring.data.dynamodb.repository.EnableScan
import org.springframework.data.repository.CrudRepository


@EnableScan
interface EventMessageRepository: CrudRepository<EventMessageEntity, String> {
}