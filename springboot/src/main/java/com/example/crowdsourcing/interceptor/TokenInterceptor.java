package com.example.crowdsourcing.interceptor;

import com.example.crowdsourcing.dao.LoginRecordRepository;
import com.example.crowdsourcing.dao.bean.LoginRecord;
import com.example.crowdsourcing.untils.MyToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class TokenInterceptor extends HandlerInterceptorAdapter {





    //除了登陆和erroe以外的所有请求都必须带token，否则返回401错误
    //但是为了测试，当带的token为heshuyu时，直接为默认账号18340019030
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        //若为登陆行为则直接通过
        if(request.getRequestURI().equals("/people")&&request.getMethod().equalsIgnoreCase("post")){
            return  true;
        }

        String token = request.getHeader("token");
        //token为空则直接返回
        if(token==null){
            response.setStatus(response.SC_UNAUTHORIZED);
            return  false;
        }else{
            if(token.equals("heshuyu")){
                token="2";
            }
            else
                token = MyToken.decrypt(token);
            request.setAttribute("token_id",token);
        }
        return super.preHandle(request, response, handler);
    }
}
