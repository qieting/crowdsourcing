package com.example.crowdsourcing.service;

import com.example.crowdsourcing.dao.bean.People;
import org.springframework.web.bind.annotation.RestController;

import javax.jws.Oneway;
import java.util.List;
import java.util.Map;


@RestController
public interface PeopleService {



//	private static PeopleService  serverHandler ;
//    @PostConstruct //通过@PostConstruct实现初始化bean之前进行的操作
//    public void init() {  
//        serverHandler = this;  
//        serverHandler.peopleRepository = this.peopleRepository;        
//        // 初使化时将已静态化的testService实例化
//    }  
//	


//	public static PeopleService getInstance() {
//
//		return peopleService;
//	}

	public Map<String,Object> login(People people) ;
	public People peopleMessage(int id);
	public int getIdByToken(int TokenId);
//	public int register(String phone_number, String password) ;
	public void changePassword(String id, String password);
	public List<People> allPeople(int page ,int limit);



	
}
