package com.example.crowdsourcing.dao;

import com.example.crowdsourcing.dao.bean.OffineOrder;
import com.example.crowdsourcing.dao.bean.OnLineOrder;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OnlineOrderRepository extends JpaRepository<OnLineOrder, Integer> {

    List<OnLineOrder> findByPlatFormLimitNotAndRemainIsGreaterThan(int platForm, int lessthan);

    List<OnLineOrder> findByPeopleId(int peopleId);

}