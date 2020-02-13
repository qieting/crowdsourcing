package com.example.crowdsourcing.dao;

import com.example.crowdsourcing.dao.bean.People;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Component;

import java.util.List;


@Component
public interface PeopleRepository extends JpaRepository<People, String> {
	
	People findByNumber(String phone_number);
	People findPeopleByQq(String qq);
	People findByWeixin(String wx);
	People findById(int id);
	int countByIdAfter(int start);

	List<People> findByIdBetween(int start , int end);

}