package com.example.crowdsourcing;

import com.example.crowdsourcing.untils.MyToken;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class CrowdsourcingApplication {

    public static void main(String[] args) {

        MyToken.init();
        SpringApplication.run(CrowdsourcingApplication.class, args);
    }

}
