package com.example.crowdsourcing.dao;

import com.example.crowdsourcing.dao.bean.LoginRecord;
import com.example.crowdsourcing.dao.bean.People;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Component;

@Component
public interface LoginRecordRepository extends JpaRepository<LoginRecord, String> {



    LoginRecord findById(int id);
    LoginRecord findByPeopleIdAndFinishTimeNull( int people_id);




}
