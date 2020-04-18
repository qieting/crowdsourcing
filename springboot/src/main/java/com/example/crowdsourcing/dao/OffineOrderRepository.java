package com.example.crowdsourcing.dao;

import com.example.crowdsourcing.dao.bean.Location;
import com.example.crowdsourcing.dao.bean.OffineOrder;
import com.example.crowdsourcing.dao.help.OffineOrderWithPeople;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface OffineOrderRepository extends JpaRepository<OffineOrder, Integer> {


    @Query(value = "SELECT new com.example.crowdsourcing.dao.help.OffineOrderWithPeople(u, a) FROM People u, OffineOrder a WHERE a.remain >?2 and a.platFormLimit <> ?1 and a.peopleId=u.id ")
    List<OffineOrderWithPeople> findByPlatFormLimitNotAndRemainIsGreaterThan(int platForm, int lessthan);

    List<OffineOrder> findByPeopleId(int peopleId);

}