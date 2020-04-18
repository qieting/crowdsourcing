package com.example.crowdsourcing.dao;

import com.example.crowdsourcing.dao.bean.OffineOrder;
import com.example.crowdsourcing.dao.bean.OnLineOrder;
import com.example.crowdsourcing.dao.help.OffineOrderWithPeople;
import com.example.crowdsourcing.dao.help.OnlineOrderWithPeople;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface OnlineOrderRepository extends JpaRepository<OnLineOrder, Integer> {


    @Query(value = "SELECT new com.example.crowdsourcing.dao.help.OnlineOrderWithPeople(u, a) FROM People u, OnLineOrder a WHERE  a.remain >?2 and  a.platFormLimit <> ?1 and a.peopleId=u.id ")
    List<OnlineOrderWithPeople> findByPlatFormLimitNotAndRemainIsGreaterThan(int platForm, int lessthan);


    List<OnLineOrder> findByPeopleId(int peopleId);


}