package com.example.crowdsourcing.dao.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.util.Date;
import java.util.List;

@Entity
public class OnLineOrdering {


    public OnLineOrdering(){

    }

    @Id
    @GeneratedValue
    int id;

    @Column
    int peopleId;

    @Column
    int onlineOrderId;

    public int getOnlineOrderId() {
        return onlineOrderId;
    }

    public void setOnlineOrderId(int onlineOrderId) {
        this.onlineOrderId = onlineOrderId;
    }

    @Column
    Date createDate;

    @Column
    Date submitDate;

    @Column
    Date finishDate;


    String resources;

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


    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getSubmitDate() {
        return submitDate;
    }

    public void setSubmitDate(Date submitDate) {
        this.submitDate = submitDate;
    }

    public Date getFinishDate() {
        return finishDate;
    }

    public void setFinishDate(Date finishDate) {
        this.finishDate = finishDate;
    }

    public String getResources() {
        return resources;
    }

    public void setResources(String resources) {
        this.resources = resources;
    }
}
