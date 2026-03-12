package com.example.items_service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class ItemsServiceApplication {

    public static void main(String[] args) {
        System.out.println(">>> Items service sdwdwdwdwdwarting!");
        SpringApplication.run(ItemsServiceApplication.class, args);
    }

    @GetMapping("/health")
    public String health() {
        return "ok";
    }
}
