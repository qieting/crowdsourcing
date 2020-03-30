package com.example.crowdsourcing.controller;


import com.example.crowdsourcing.Myannotation.CurrentUserId;
import com.example.crowdsourcing.dao.bean.*;
import com.example.crowdsourcing.service.PeopleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.support.StandardMultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Enumeration;
import java.util.HashMap;
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
    @ResponseBody //将返回的java对象变为string
    public List<People> allPeople(@RequestParam(value = "page", defaultValue = "0") int page, @RequestParam(value = "limit", defaultValue = "10") int limit) {

        return peopleService.allPeople(page, limit);
    }

    // 返回-1代表账号不存在，返回-2代表密码错误，登陆成功则返回1
    @RequestMapping(value = "/people", method = RequestMethod.POST)
    public Map<String, Object> login(@RequestBody People people) {
        System.out.println(people);
        return peopleService.login(people);
    }

    // 返回-1代表账号不存在，返回-2代表密码错误，登陆成功则返回1
    @RequestMapping(value = "/people", method = RequestMethod.PUT)
    public People changeMessage(@CurrentUserId int id, @RequestBody People people) {
        return peopleService.changeMessage(id, people);
    }


    // 返回-1代表账号不存在，返回-2代表密码错误，登陆成功则返回1
    @RequestMapping(value = "/people", method = RequestMethod.GET)
    public Map<String, Object> getMessage(@CurrentUserId int id) {

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


    @RequestMapping(value = "/location", method = RequestMethod.POST)
    public void addLocation(@RequestBody Location location, @CurrentUserId int id) {
        peopleService.addLocation(id, location);
    }

    @RequestMapping(value = "/location", method = RequestMethod.GET)
    public Object getLocations(@CurrentUserId int id, @RequestParam(name = "LocationId", defaultValue = "0") int location_id) {
        if (location_id != 0)
            return peopleService.getLocations(id);
        else {
            return peopleService.getLocation(id, location_id);
        }
    }

    @RequestMapping(value = "/location", method = RequestMethod.PUT)
    public void ChangeLocationsMain(@CurrentUserId int id, @RequestBody Location location) {
        peopleService.changeLocation(id, location);
    }

    @RequestMapping(value = "/location", method = RequestMethod.DELETE)
    public void deleteLocation(@CurrentUserId int id, @RequestBody Location location) {

        peopleService.deleteLocation(id, location.getId());
    }

    @RequestMapping(value = "/offineOrder", method = RequestMethod.POST)
    public void addOffineOrder(@RequestBody OffineOrder offineOrder, @CurrentUserId int id) {
        peopleService.addOffineOrder(id, offineOrder);
    }

    @RequestMapping(value = "/offineOrder", method = RequestMethod.GET)
    public List<OffineOrder> getOffineOrders(@RequestParam("platForm") int platForm) {
        return peopleService.getOffineOrders(platForm);
    }





    @RequestMapping(value = "/offineOrdering", method = RequestMethod.POST)
    //此处的int要写为Integer，因为这个值可能为空，那么要可以支持空类型
    public OffineOrdering  addOffineOrdering( @RequestBody Integer  offineOrderId, @CurrentUserId int id) {
       return  peopleService.addOffineOrdering(id, offineOrderId);
    }

    @RequestMapping(value = "/offineOrdering", method = RequestMethod.PUT)
    public void finishOffineOrdering(@RequestParam("offineOrderId") int  offineOrderId) {
        peopleService.finishOffineOrdering(offineOrderId);
    }

    @RequestMapping(value = "/offineOrdering", method = RequestMethod.GET)
    public List<OffineOrdering> getOffineOrderings(@CurrentUserId  int id) {
        return peopleService.getOffineOrdering(id);
    }


    @RequestMapping(value = "/onlineOrder", method = RequestMethod.POST)
    public OnLineOrder addOnLineOrder(OnLineOrder onLineOrder, List<MultipartFile> files, @CurrentUserId int id) {

      return   peopleService.addOnLineOrder(id,onLineOrder,files);
    }

    @RequestMapping(value = "/onlineOrder", method = RequestMethod.GET)
    public List<OnLineOrder> getOnLineOrders(@RequestParam("platForm") int platForm) {
        return peopleService.getOnLineOrders(platForm);
    }

    @RequestMapping(value = "/onlineOrdering", method = RequestMethod.GET)
    public List<OnLineOrdering> getOnLineOrderings(@CurrentUserId  int id) {
        return peopleService.getOnLineOrdering(id);
    }

    @RequestMapping(value = "/order", method = RequestMethod.GET)
    public Map<String ,List> getorders(@RequestParam("platForm") int platForm) {
        return peopleService.getOrders(platForm);
    }

    @RequestMapping(value = "/onlineOrdering", method = RequestMethod.POST)
    //此处的int要写为Integer，因为这个值可能为空，那么要可以支持空类型
    public OnLineOrdering  addOnLineOrdering( @RequestBody Integer  onlineOrderId, @CurrentUserId int id) {
        return  peopleService.addOnLineOrdering(onlineOrderId,id);
    }

    @RequestMapping(value = "/onlineOrdering", method = RequestMethod.PUT)
    //此处的int要写为Integer，因为这个值可能为空，那么要可以支持空类型
    public OnLineOrdering  addOnLineOrdering(  HttpServletRequest request) {
        MultipartHttpServletRequest params=((MultipartHttpServletRequest) request);
        Map<String,MultipartFile> files = params.getFileMap();
        Map<String,String> phones =new HashMap<>();
        Enumeration<String>  ss =params.getParameterNames();
        while (ss.hasMoreElements()){
            String as =ss.nextElement();
             phones.put(as,params.getParameter(as));
        }
     //   return  null;
        return  peopleService. ChangeOnlineOrdering(phones,files);
    }


}
