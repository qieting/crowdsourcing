package com.example.crowdsourcing.dao;

import com.example.crowdsourcing.dao.bean.OffineOrdering;
import com.example.crowdsourcing.dao.bean.OnLineOrder;
import com.example.crowdsourcing.dao.bean.OnLineOrdering;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OnlineOrderingRepository extends JpaRepository<OnLineOrdering, Integer> {



    List<OnLineOrdering> findByPeopleId(int peopleId);
}