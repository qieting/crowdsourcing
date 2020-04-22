package com.example.crowdsourcing.service;

import com.example.crowdsourcing.dao.bean.*;
import com.example.crowdsourcing.dao.help.OffineOrderWithPeople;
import com.example.crowdsourcing.dao.help.OnlineOrderWithPeople;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;


//这里没有做接口的分离，全部放在了这一个接口文档里
@RestController
public interface PeopleService {



	//用户个人信息相关方法
	public Map<String,Object> login(People people) ;
	public  Map<String ,Object> peopleMessage(int id);
	public void changePassword(String id, String password);
	public People changeMessage(int id,People people);


	public List<People> allPeople(int page ,int limit);


	//离线任务位置相关
	public List<Location> getLocations(int peopleid);
	public Location getLocation(int peopleid,int locationId);
	public void  addLocation(int peopleid, Location location);
	public void deleteLocation(int peopleid,int id);
	public void changeLocation(int peopleid,Location location);



	public void  addOffineOrder(int peopleid, OffineOrder offineOrder);
	public List<OffineOrderWithPeople>  getOffineOrders(int platForm);
	public List<OffineOrder>  getOffineOrdersByPeople(int peopleId);


	public OffineOrdering  addOffineOrdering(int  offineOrderId ,int peopleId);
	public void  finishOffineOrdering(int  offineOrderingId);
	public List<OffineOrdering>  getOffineOrdering(int  peopleId);
	public Map<String,Object>  getOffineOrdering(int  peopleId,int OffineOrderid);



	public OnLineOrder  addOnLineOrder(int peopleid, OnLineOrder offineOrder, List<MultipartFile> files);
	public List<OnlineOrderWithPeople>  getOnLineOrders(int platForm);
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
