package com.example.crowdsourcing.controller;


import com.example.crowdsourcing.Myannotation.CurrentUserId;
import com.example.crowdsourcing.dao.bean.LoginRecord;
import com.example.crowdsourcing.dao.bean.People;
import com.example.crowdsourcing.service.PeopleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RestController
public class MyController {

    @Autowired
    PeopleService peopleService;


    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index() {
        return "正常使用";
    }

    @RequestMapping(value = "/peoples", method = RequestMethod.GET)
    @ResponseBody
    public List<People> allPeople(@RequestParam(value = "page", defaultValue = "0") int page, @RequestParam(value = "limit", defaultValue = "10") int limit) {

        return peopleService.allPeople(page, limit);
    }

    // 返回-1代表账号不存在，返回-2代表密码错误，登陆成功则返回1
    @RequestMapping(value = "/people", method = RequestMethod.POST)
    public Map<String, Object> login(@RequestBody People people) {
        System.out.println(people);
        return peopleService.login(people);
    }


//    // 返回-1代表账号不存在，返回-2代表密码错误，登陆成功则返回1
//    @RequestMapping(value = "/people/phone", method = RequestMethod.GET)
//    public Map<String, Object> loginOnlyByphone(@RequestParam("phone") String phone_number) {
//        return  peopleService.login(phone_number);
//    }


    // 返回0代表账号已经被注册，否则返回1
    @RequestMapping(value = "/people", method = RequestMethod.GET)
    public People register(@CurrentUserId int id) {
        //System.out.println(id);
        return peopleService.peopleMessage(id);
    }

    // 返回0代表账号已经被注册，否则返回1
    @RequestMapping(value = "/changePassword")
    public int changePassword(@RequestParam("number") String phone_number, @RequestParam("password") String pass_word,
                              HttpSession session) {
        peopleService.changePassword(phone_number, pass_word);
        session.setAttribute("id", phone_number);
        return 1;
    }

}
