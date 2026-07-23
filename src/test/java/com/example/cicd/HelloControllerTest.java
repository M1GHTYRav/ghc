package com.example.cicd;

import static org.hamcrest.Matchers.containsString;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest
@AutoConfigureMockMvc
class HelloControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void homeEndpointReturnsSuccess() throws Exception {
        mockMvc.perform(get("/"))
            .andExpect(status().isOk())
            .andExpect(content().string(
                containsString("Java Gradle Docker CI/CD is working")
            ));
    }

    @Test
    void healthEndpointReturnsUp() throws Exception {
        mockMvc.perform(get("/health"))
            .andExpect(status().isOk())
            .andExpect(content().string(containsString("UP")));
    }

    @Test
    void greetingEndpointUsesProvidedName() throws Exception {
        mockMvc.perform(get("/api/greeting").param("name", "Scott"))
            .andExpect(status().isOk())
            .andExpect(content().string(containsString("Hello, Scott!")));
    }
}
