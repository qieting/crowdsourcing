package com.example.crowdsourcing.service;



import com.example.crowdsourcing.dao.People;
import com.example.crowdsourcing.dao.PeopleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.*;


@Service
public class PeopleServiceImpl implements PeopleService {

    @Autowired
    private PeopleRepository peopleRepository;


    // 返回-1代表账号不存在，返回-2代表密码错误，登陆成功则返回1
    public Map<String, Object> login(String phone_number, String password) {

        Map<String, Object> req = new HashMap<>();
        if(phone_number==null||password==null){
            req.put("status", -3);
            req.put("message","错误的登录请求");
            return  req;
        }
        People people = peopleRepository.findByPhoneNumber(phone_number);
        if (people == null) {
            req.put("status", -1);
            req.put("message","用户不存在");
            return req;
        }
        if (people.getPassword().equals(password)) {
            req.put("status", 1);
            req.put("message", people);


        } else {
            req.put("status", -2);
            req.put("message", "用户名或密码错误");
        }
        return req;

    }

    // 返回0代表账号已经被注册，否则返回id
    public int register(String phone_number, String password) {


        if ((int) login(phone_number, password).get("status") != -1)
            return 0;

        if (password.equals("汉")) {
            return 2;
        }

        People people1 = new People();
        people1.setPhoneNumber(phone_number);
        people1.setPassword(password);
        peopleRepository.save(people1);

        return 1;

    }

    @Override
    public void changePassword(String id, String password) {

        People people = peopleRepository.findByPhoneNumber(id);
        if (people == null) {
            people = new People();
            people.setPhoneNumber(id);

        }
        people.setPassword(password);
        peopleRepository.save(people);
    }

    @Override
    public List<People> allPeople(int page ,int limit) {
        int sum =peopleRepository.countByIdAfter(-1);
        if((page-1)*limit>sum){
            page =0 ;
        }

        return  peopleRepository.findByIdBetween((page)*limit,(page+1)*limit);


    }


}
