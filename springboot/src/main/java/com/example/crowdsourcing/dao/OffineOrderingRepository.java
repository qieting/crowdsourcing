package com.example.crowdsourcing.dao;

import com.example.crowdsourcing.dao.bean.OffineOrder;
import com.example.crowdsourcing.dao.bean.OffineOrdering;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OffineOrderingRepository extends JpaRepository<OffineOrdering, Integer> {



    List<OffineOrdering> findByPeopleId(int peopleId);
}