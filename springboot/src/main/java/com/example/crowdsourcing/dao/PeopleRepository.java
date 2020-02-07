package com.example.crowdsourcing.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Component;

import java.util.List;


@Component
public interface PeopleRepository extends JpaRepository<People, String> {
	
	People findByPhoneNumber(String phone_number);

	int countByIdAfter(int start);

	List<People> findByIdBetween(int start , int end);





}