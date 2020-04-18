package com.example.crowdsourcing.dao.help;

import com.example.crowdsourcing.dao.bean.OffineOrder;
import com.example.crowdsourcing.dao.bean.People;

import java.io.Serializable;

public class OffineOrderWithPeople implements Serializable {

    private static final long serialVersionUID = -6347911007178390219L;
    private People user;

    public People getUser() {
        return user;
    }

    public void setUser(People user) {
        this.user = user;
    }

    public OffineOrder getOffineOrder() {
        return offineOrder;
    }

    public void setOffineOrder(OffineOrder offineOrder) {
        this.offineOrder = offineOrder;
    }

    private OffineOrder offineOrder;


    public OffineOrderWithPeople(People user, OffineOrder offineOrder) {
        this.user = user;
        this.offineOrder = offineOrder;
    }




}