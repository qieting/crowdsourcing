package com.example.crowdsourcing.service;

import com.example.crowdsourcing.dao.bean.*;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

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
	public  Map<String ,Object> peopleMessage(int id);
//	public int getIdByToken(int TokenId);
//	public int register(String phone_number, String password) ;
	public void changePassword(String id, String password);
	public List<People> allPeople(int page ,int limit);
	public People changeMessage(int id,People people);

	public List<Location> getLocations(int peopleid);
	public Location getLocation(int peopleid,int locationId);
	public void  addLocation(int peopleid, Location location);
	public void deleteLocation(int peopleid,int id);
	public void changeLocation(int peopleid,Location location);

	public void  addOffineOrder(int peopleid, OffineOrder offineOrder);
	public List<OffineOrder>  getOffineOrders(int platForm);
	public List<OffineOrder>  getOffineOrdersByPeople(int peopleId);


	public OffineOrdering  addOffineOrdering(int  offineOrderId ,int peopleId);
	public void  finishOffineOrdering(int  offineOrderingId);
	public List<OffineOrdering>  getOffineOrdering(int  peopleId);
	public Map<String,Object>  getOffineOrdering(int  peopleId,int OffineOrderid);



	public OnLineOrder  addOnLineOrder(int peopleid, OnLineOrder offineOrder, List<MultipartFile> files);
	public List<OnLineOrder>  getOnLineOrders(int platForm);
	public List<OnLineOrder>  getOnLineOrdersByPeople(int peopleId);
	public void   ChangeOnLineOrder(int peopleid, OnLineOrder  onLineOrder);

	public OnLineOrdering  addOnLineOrdering(int  onLineOrderId ,int peopleId);
	public void  finishOnLineOrdering(int  onLineOrderingId);
	public OnLineOrdering ChangeOnlineOrdering( Map<String ,String> phones , Map<String ,MultipartFile>files);
	public List<OnLineOrdering>  getOnLineOrdering(int  peopleId);
	public Map<String ,Object>  getOnLineOrdering(int  peopleId,int OnlineOrderId);


	public  Map<String,List>  getOrders(int platForm);
	public  List  getMyTakeOrders(int id, int type,boolean online);
	public  OnLineOrdering finishOnlineOrdering(int orderId ,boolean finish ,String reason);

	public  void addMoney(int peopleId , double money);
	public String addFile(int id,MultipartFile file);




	
}
