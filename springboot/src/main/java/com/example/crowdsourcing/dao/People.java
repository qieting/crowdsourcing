package com.example.crowdsourcing.dao;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.io.Serializable;

@Entity
public class People implements Serializable {


    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue
    private  int id;

    @Column(name = "phone_number", unique = true)
    private String phoneNumber;

    @Column(name = "pass_word")
    private String password;

    @Column(name = "weixin")
    private String weixin;

    @Column(name = "qq")
    private String qq;




    public People() {
    }


    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getWeixin() {
        return weixin;
    }

    public void setWeixin(String weixin) {
        this.weixin = weixin;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

}
