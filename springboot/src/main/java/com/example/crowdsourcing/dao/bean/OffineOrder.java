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







    @Column
    int end;
    @Column
    double price;

    //总数
    @Column
    int total;
    //剩余未领
    @Column
    int remain;
    //等待审核
    @Column
    int  submit;


    //已经完成
    @Column
    int finish;
    //还有一个，就是领了任务还没有做的，那么就是t-r-s-f


    public int getSubmit() {
        return submit;
    }

    public void setSubmit(int submit) {
        this.submit = submit;
    }


    public int getFinish() {
        return finish;
    }

    public void setFinish(int finish) {
        this.finish = finish;
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

    public int getEnd() {
        return end;
    }

    public void setEnd(int end) {
        this.end = end;
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

    public void remainMinus(){
        remain--;
    }

    public void sumbitR(){
        finish++;
    }


}
