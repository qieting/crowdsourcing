package com.example.crowdsourcing.dao.bean;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.util.Date;

@Entity
public class OffineOrdering {


    @Id
    @GeneratedValue
    int id;

    @Column
    int peopleId;

    @Column
    int offineOrderId;

    @Column
    Date createDate;

    @Column
    Date finishDate;


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

    public int getOffineOrderId() {
        return offineOrderId;
    }

    public void setOffineOrderId(int offineOrderId) {
        this. offineOrderId = offineOrderId;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getFinishDate() {
        return finishDate;
    }

    public void setFinishDate(Date finishDate) {
        this.finishDate = finishDate;
    }





}
