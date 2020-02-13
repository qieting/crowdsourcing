package com.example.crowdsourcing.dao.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.util.Date;

@Entity
public class LoginRecord {
    private static final long serialVersionUID = 1L;


    public enum WAY{QQ, WEIXIN,NUMBER,NUMBERPSD}

    @Id
    @GeneratedValue
    private  int id;

    @Column(name = "people_id")
    private int peopleId;


    @Column(name = "created_time")
    private Date createdTime;

    @Column(name = "app_id")
    private String appid;


    public WAY getWay() {
        return way;
    }

    public void setWay(WAY way) {
        this.way = way;
    }

    @Column(name = "way")
    private WAY way;


    @Column(name = "finish_tiem")
    private Date finishTime;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int  getPeopleId() {
        return peopleId;
    }

    public void setPeopleId(int peopleId) {
        this.peopleId = peopleId;
    }

    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public String getAppid() {
        return appid;
    }

    public void setAppid(String appid) {
        this.appid = appid;
    }



    public Date getFinishTime() {
        return finishTime;
    }

    public void setFinishTime(Date finishTime) {
        this.finishTime = finishTime;
    }





}
