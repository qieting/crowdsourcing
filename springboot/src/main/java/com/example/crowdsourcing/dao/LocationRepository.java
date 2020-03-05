package com.example.crowdsourcing.dao;

import com.example.crowdsourcing.dao.bean.Location;
import com.example.crowdsourcing.dao.bean.People;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LocationRepository extends JpaRepository<Location, Integer> {

    List<Location> findByPeopleIdAndDeleteFalseOrderByMain( int id);
    Location findByMainTrueAndDeleteFalseAndPeopleId(int id);

}