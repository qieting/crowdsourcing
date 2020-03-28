package com.example.crowdsourcing.dao.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class OnLineOrder {

    public OnLineOrder(){

    }

    @Column
    String onlineSteps;

    @Id
    @GeneratedValue
    private int id;

    @Column
    int peopleId;
    @Column
    private String title, limitedTime;
    @Column(name = "des")
    String describe;
    @Column(name = "requir")
    String require;

    // 0 代表无限制    1代表安卓 2代表苹果
    @Column
    int platFormLimit;
    @Column
    int total;
    @Column
    int remain;

    @Column
    double price;

    public String getOnlineSteps() {
        return onlineSteps;
    }

    public void setOnlineSteps(String onlineSteps) {
        this.onlineSteps = onlineSteps;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPeopleId() {
        return peopleId;
    }

    public void setPeopleId(int peopleId) {
        this.peopleId = peopleId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLimitedTime() {
        return limitedTime;
    }

    public void setLimitedTime(String limitedTime) {
        this.limitedTime = limitedTime;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getRequire() {
        return require;
    }

    public void setRequire(String require) {
        this.require = require;
    }

    public int getPlatFormLimit() {
        return platFormLimit;
    }

    public void setPlatFormLimit(int platFormLimit) {
        this.platFormLimit = platFormLimit;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getRemain() {
        return remain;
    }

    public void setRemain(int remain) {
        this.remain = remain;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
