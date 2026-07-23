package com.example.cicd;

import java.time.Instant;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/")
    public Map<String, String> home() {
        return Map.of(
            "application", "java-gradle-cicd",
            "message", "Java Gradle Docker CI/CD is working"
        );
    }

    @GetMapping("/health")
    public Map<String, String> health() {
        return Map.of(
            "status", "UP",
            "timestamp", Instant.now().toString()
        );
    }

    @GetMapping("/api/greeting")
    public Map<String, String> greeting(
            @RequestParam(defaultValue = "Developer") String name) {
        return Map.of(
            "message", "Hello, " + name + "!",
            "pipeline", "Gradle + Docker + GitHub Actions"
        );
    }
}
