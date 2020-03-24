package com.example.crowdsourcing.dao.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class OffineOrder {


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
    String buyMessages;

    // 0代表无人接   1代表有人接但是还有空   2代表全部接但是没完成(离线任务只有一个人接，默认没有这个状态）   3代表完成
    @Column()
    int wancheng;

    public int getWancheng() {
        return wancheng;
    }

    public void setWancheng(int wancheng) {
        this.wancheng = wancheng;
    }

    public int getEnd() {
        return end;
    }

    public void setEnd(int end) {
        this.end = end;
    }

    @Column
    int end;
    @Column
    double price;


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

    public String getLimitedTime() {
        return limitedTime;
    }

    public void setLimitedTime(String limitedTime) {
        this.limitedTime = limitedTime;
    }

    public int getPlatFormLimit() {
        return platFormLimit;
    }

    public void setPlatFormLimit(int platFormLimit) {
        this.platFormLimit = platFormLimit;
    }

    public String getBuyMessages() {
        return buyMessages;
    }

    public void setBuyMessages(String buyMessages) {
        this.buyMessages = buyMessages;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }


}
