package com.example.crowdsourcing.interceptor;

import com.example.crowdsourcing.dao.LoginRecordRepository;
import com.example.crowdsourcing.dao.bean.LoginRecord;
import com.example.crowdsourcing.untils.MyToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class TokenInterceptor extends HandlerInterceptorAdapter {


    @Autowired
    LoginRecordRepository loginRecordRepository;

    //通过下面的代码实现loginRecordRepository初始化，在调用时统一使用tokenInterception调用
    public static TokenInterceptor tokenInterceptor;

    @PostConstruct //通过@PostConstruct实现初始化bean之前进行的操作
    public void init() {
        tokenInterceptor = this;
        tokenInterceptor.loginRecordRepository = this.loginRecordRepository;
    }


    //除了登陆和erroe以外的所有请求都必须带token，否则返回401错误
    //但是为了测试，当带的token为heshuyu时，直接为默认账号18340019030
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        if (tokenInterceptor.loginRecordRepository == null) {
            throw new Exception("空");
        }

        //若为登陆行为则直接通过
        if (request.getRequestURI().equals("/people") && request.getMethod().equalsIgnoreCase("post")) {
            return true;
        }

        String token = request.getHeader("token");
        //token为空则直接返回
        if (token == null) {
            response.setStatus(response.SC_UNAUTHORIZED);
            return false;
        } else {
            if (token.equals("heshuyu")) {
                token = "2";
            } else
                token = MyToken.decrypt(token);
            LoginRecord loginRecord = tokenInterceptor.loginRecordRepository.findById(Integer.parseInt(token));
            if (loginRecord == null) {
                response.setStatus(response.SC_UNAUTHORIZED);
                return false;
            } else if (loginRecord.getFinishTime() != null) {
                response.setStatus(response.SC_EXPECTATION_FAILED);
                return false;
            }

            request.setAttribute("id", loginRecord.getPeopleId());
        }
        return super.preHandle(request, response, handler);
    }
}
