package com.example.crowdsourcing.dao;

import com.example.crowdsourcing.dao.bean.Location;
import com.example.crowdsourcing.dao.bean.OffineOrder;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OffineOrderRepository extends JpaRepository<OffineOrder, Integer> {

    List<OffineOrder> findByPlatFormLimitNotAndWanchengIsLessThan(int platForm, int lessthan);

    List<OffineOrder> findByPeopleId(int peopleId);

}