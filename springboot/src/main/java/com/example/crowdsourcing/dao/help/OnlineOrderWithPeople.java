package com.example.crowdsourcing.dao.help;


import com.example.crowdsourcing.dao.bean.OnLineOrder;
import com.example.crowdsourcing.dao.bean.People;

import java.io.Serializable;

public class OnlineOrderWithPeople implements Serializable {

    private static final long serialVersionUID = -6347911007178390219L;
    private People user;

    public People getUser() {
        return user;
    }

    public void setUser(People user) {
        this.user = user;
    }

    public OnLineOrder getOnLineOrder() {
        return onlineOrder;
    }

    public void setOnLineOrder(OnLineOrder onlineOrder) {
        this.onlineOrder = onlineOrder;
    }

    private OnLineOrder onlineOrder;


    public OnlineOrderWithPeople(People user, OnLineOrder onlineOrder) {
        this.user = user;
        this.onlineOrder = onlineOrder;
    }




}