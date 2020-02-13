package com.example.crowdsourcing.interceptor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.ArrayList;
import java.util.List;

@Configuration
public class WebConfig implements WebMvcConfigurer {


    @Override
    public  void  addInterceptors(InterceptorRegistry registry){
        //registry.addInterceptor(new RSAInterceptor());

        List<String> tokenExclude = new ArrayList<>();
        tokenExclude.add("/error");
        tokenExclude.add("");
        registry.addInterceptor(new TokenInterceptor()).excludePathPatterns(tokenExclude);


    }
}
