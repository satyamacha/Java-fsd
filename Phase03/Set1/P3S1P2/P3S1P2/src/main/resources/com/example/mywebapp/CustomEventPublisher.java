package com.example.mywebapp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Component;

@Component
public class CustomEventPublisher {
    @Autowired
    private ApplicationEventPublisher eventPublisher;

    public void publishCustomEvent(String message) {
        CustomEvent event = new CustomEvent(message);
        eventPublisher.publishEvent(event);
    }
}
