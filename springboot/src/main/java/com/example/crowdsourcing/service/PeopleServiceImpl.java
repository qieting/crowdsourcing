package com.example.crowdsourcing.service;


import com.example.crowdsourcing.dao.*;
import com.example.crowdsourcing.dao.bean.*;
import com.example.crowdsourcing.untils.MyToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;


@Service
public class PeopleServiceImpl implements PeopleService {

    @Autowired
    private PeopleRepository peopleRepository;
    @Autowired
    private LoginRecordRepository loginRecordRepository;
    @Autowired
    private LocationRepository locationRepository;
    @Autowired
    private OffineOrderRepository offineOrderRepository;
    @Autowired
    private OffineOrderingRepository offineOrderingRepository;
    @Autowired
    private OnlineOrderingRepository onlineOrderingRepository;
    @Autowired
    private OnlineOrderRepository onlineOrderRepository;

    // status为-1代表账号不存在，返回-2代表密码错误，登陆成功则返回1
    public Map<String, Object> login(People people) {

        Map<String, Object> req = new HashMap<>();
        LoginRecord loginRecord = new LoginRecord();
        People people1;
        //微信
        if (people.getWeixin() != null) {
            loginRecord.setWay(LoginRecord.WAY.WEIXIN);
            people1 = peopleRepository.findByWeixin(people.getWeixin());
            if (people1 == null) {
                peopleRepository.save(people);
                people1 = peopleRepository.findByWeixin(people.getWeixin());
                req.put("register", true);
            }
            //QQ
        } else if (people.getQq() != null) {
            loginRecord.setWay(LoginRecord.WAY.QQ);
            people1 = peopleRepository.findPeopleByQq(people.getQq());
            if (people1 == null) {

                peopleRepository.save(people);
                people1 = peopleRepository.findPeopleByQq(people.getQq());
                req.put("register", true);
            }
            //手机号登陆，分为单纯手机号和账号密码两种
        } else if (people.getNumber() != null) {
            people1 = peopleRepository.findByNumber(people.getNumber());

            //带密码登陆
            if (people.getPassword() != null) {
                loginRecord.setWay(LoginRecord.WAY.NUMBERPSD);
                if (people1 == null) {
                    req.put("status", -1);
                    req.put("message", "用户名不存在");
                    return req;
                } else if (!people1.getPassword().equals(people.getPassword())) {
                    req.put("status", -2);
                    req.put("message", "用户名或密码错误");
                    return req;
                }
                //单纯手机号
            } else {
                if (people1 == null) {
                    peopleRepository.save(people);
                    people1 = peopleRepository.findByNumber(people.getNumber());
                    req.put("register", true);
                } else {
                    //没有密码，则代表直接使用手机号登陆
                }
                loginRecord.setWay(LoginRecord.WAY.NUMBER);
            }
        } else {
            req.put("status", -1);
            req.put("message", "错误的登录请求");
            return req;
        }

        if (people1.getId() < 0) {
            req.put("status", -2);
            req.put("message", "用户名或密码错误");
        }
        req.put("status", 1);
        req.put("message", people1);

        LoginRecord last = loginRecordRepository.findByPeopleIdAndFinishTimeNull(people1.getId());
        if (last != null) {
            last.setFinishTime(new Date());
            loginRecordRepository.save(last);
        }


        System.out.println(req.get("token"));
        loginRecord.setCreatedTime(new Date());
        loginRecord.setPeopleId(people1.getId());
        loginRecord = loginRecordRepository.save(loginRecord);

        try {
            req.put("token", MyToken.encrypt("" + loginRecord.getId()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        req.put("offineOrdering", getOffineOrdering(people1.getId()));
        req.put("offineOrder", getOnLineOrdersByPeople(people1.getId()));
        req.put("onlineOrdering", getOnLineOrdering(people1.getId()));
        req.put("onlineOrder", getOnLineOrdersByPeople(people1.getId()));
        req.put("location", locationRepository.findByPeopleIdAndDeleteFalseOrderByMain(people1.getId()));
        return req;

    }

    @Override
    public Map<String, Object> peopleMessage(int id) {

        Map<String, Object> map = new HashMap<>();
        map.put("message", peopleRepository.findById(id));
        map.put("locations", locationRepository.findByPeopleIdAndDeleteFalseOrderByMain(id));
        map.put("offineOrdering", getOffineOrdering(id));
        map.put("offineOrder", getOffineOrdersByPeople(id));
        return map;
    }


//    @Override
//    public int getIdByToken(int tokenId) {
//        LoginRecord loginRecord = loginRecordRepository.findById(tokenId);
//        if (loginRecord==null){
//            return -1;
//        }else if (loginRecord.getFinishTime()!=null){
//            return  -2;
//        }else{
//            return loginRecord.getPeopleId();
//        }
//    }

//    // 返回0代表账号已经被注册，否则返回id
//    public int register(String phone_number, String password) {
//
//
//        if ((int) login(phone_number, password).get("status") != -1)
//            return 0;
//
//        if (password.equals("汉")) {
//            return 2;
//        }
//
//        People people1 = new People();
//        people1.setPhoneNumber(phone_number);
//        people1.setPassword(password);
//        peopleRepository.save(people1);
//
//        return 1;
//
//    }

    @Override
    public void changePassword(String id, String password) {

        People people = peopleRepository.findByNumber(id);
        if (people == null) {
            people = new People();
            people.setNumber(id);

        }
        people.setPassword(password);
        peopleRepository.save(people);
    }

    @Override
    public List<People> allPeople(int page, int limit) {
        int sum = peopleRepository.countByIdAfter(-1);
        if ((page - 1) * limit > sum) {
            page = 0;
        }

        return peopleRepository.findByIdBetween((page) * limit, (page + 1) * limit);


    }

    @Override
    public People changeMessage(int id, People people) {
        People people1 = peopleRepository.findById(id);
        people1.change(people);
        peopleRepository.save(people1);
        return people1;
    }

    @Override
    public List<Location> getLocations(int peopleid) {
        return locationRepository.findByPeopleIdAndDeleteFalseOrderByMain(peopleid);
    }

    @Override
    public Location getLocation(int peopleid, int locationId) {
        return locationRepository.findById(locationId).get();
    }

    @Override
    public void addLocation(int peopleid, Location location) {
        location.setPeopleId(peopleid);
        if (location.isMain()) {
            Location llll = locationRepository.findByMainTrueAndDeleteFalseAndPeopleId(peopleid);
            if (llll != null) {
                llll.setMain(false);
                locationRepository.save(llll);
            }
        }
        locationRepository.save(location);
    }

    @Override
    public void deleteLocation(int peopleid, int id) {
        Location location = locationRepository.findById(id).get();
        if (location != null) {
            location.setDelete(true);
            locationRepository.save(location);
        }
    }

    @Override
    public void changeLocation(int peopleid, Location location) {
        location.setPeopleId(peopleid);
        if (location.isMain()) {
            Location llll = locationRepository.findByMainTrueAndDeleteFalseAndPeopleId(peopleid);
            if (llll != null) {
                llll.setMain(false);
                locationRepository.save(llll);
            }
        }
        locationRepository.save(location);

    }

    @Override
    public void addOffineOrder(int peopleid, OffineOrder offineOrder) {
        offineOrder.setPeopleId(peopleid);
        offineOrderRepository.save(offineOrder);
    }

    @Override
    public List<OffineOrder> getOffineOrders(int platForm) {
        if (platForm == 1) {
            platForm = 2;
        } else {
            platForm = 1;
        }
        List<OffineOrder> offineOrders = offineOrderRepository.findByPlatFormLimitNotAndRemainIsGreaterThan(platForm, 0);
        return offineOrders;
    }

    @Override
    public List<OffineOrder> getOffineOrdersByPeople(int peopleId) {
        return offineOrderRepository.findByPeopleId(peopleId);
    }

    @Override
    public void ChangeOffineOrder(int peopleid, OffineOrder offineOrder) {
        offineOrderRepository.save(offineOrder);
    }

    @Override
    public OffineOrdering  addOffineOrdering(int  peopleId, int offineOrderId) {

        OffineOrder offineOrder =offineOrderRepository.findById(offineOrderId).get();
        if(offineOrder.getRemain()==0){
            return null;
        }else{
            offineOrder.remainMinus();
        }
        offineOrderRepository.save(offineOrder);

        OffineOrdering offineOrdering = new OffineOrdering();
        offineOrdering.setPeopleId(peopleId);
        offineOrdering.setOffineOrderId(offineOrderId);
        offineOrdering.setCreateDate(new Date());
        offineOrderingRepository.save(offineOrdering);
        return  offineOrdering;
    }

    @Override
    public void finishOffineOrdering(int offineOrderingId) {
        OffineOrdering offineOrdering = offineOrderingRepository.findById(offineOrderingId).get();
        offineOrdering.setFinishDate(new Date());
        offineOrderingRepository.save(offineOrdering);
    }

    @Override
    public List<OffineOrdering> getOffineOrdering(int peopleId) {
        return offineOrderingRepository.findByPeopleId(peopleId);
    }

    @Override
    public void addOnLineOrder(int peopleid, OnLineOrder offineOrder) {

    }

    @Override
    public List<OnLineOrder> getOnLineOrders(int platForm) {
        return  onlineOrderRepository.findByPlatFormLimitNotAndRemainIsGreaterThan(platForm,0);
    }

    @Override
    public List<OnLineOrder> getOnLineOrdersByPeople(int peopleId) {
        return null;
    }

    @Override
    public void ChangeOnLineOrder(int peopleid, OnLineOrder onLineOrder) {

    }

    @Override
    public OnLineOrdering addOnLineOrdering(int onLineOrderId, int peopleId) {
        return null;
    }

    @Override
    public void finishOnLineOrdering(int onLineOrderingId) {

    }

    @Override
    public List<OnLineOrdering> getOnLineOrdering(int peopleId) {
        return onlineOrderingRepository.findByPeopleId(peopleId);
    }


}
