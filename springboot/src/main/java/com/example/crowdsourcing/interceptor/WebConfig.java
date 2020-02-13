package com.example.crowdsourcing.interceptor;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.ArrayList;
import java.util.List;

@Configuration
public class WebConfig extends WebMvcConfigurationSupport {

    /**
     * 增加了参数解析器，这里理解增加这个注解器的原因是，我们在拦截器中增加的参数不能在controller被读取，因此需要增加这个
     *
     * @param argumentResolvers
     */
    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
        argumentResolvers.add(currentUserMethodArgumentResolver());
        super.addArgumentResolvers(argumentResolvers);
    }



    @Bean
    public CurrentUserMethodArgumentResolver currentUserMethodArgumentResolver() {
        return new CurrentUserMethodArgumentResolver();
    }
    @Override
    public  void  addInterceptors(InterceptorRegistry registry){
        //registry.addInterceptor(new RSAInterceptor());

        List<String> tokenExclude = new ArrayList<>();
        tokenExclude.add("/error");
        tokenExclude.add("");
        registry.addInterceptor(new TokenInterceptor()).excludePathPatterns(tokenExclude);


    }
}
