package com.example.crowdsourcing.dao.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Date;

@Entity
public class People implements Serializable {


    private static final long serialVersionUID = 1L;




    @Id
    @GeneratedValue
    private  int id;

    @Column(name = "number", unique = true)
    private String number;

    @Column(name = "pass_word")
    private String password;

    @Column(name = "weixin", unique = true)
    private String weixin;

    @Column(name = "qq", unique = true)
    private String qq;

    @Column(updatable = false)
    private Date date  =new Date();




    public People() {
    }


    @Override
    public String toString(){
        return  id+","+number+","+password+','+weixin+","+qq;
    };

    public String getNumber() {
        return number;
    }

    public void setNumber(String phoneNumber) {
        this.number = phoneNumber;
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
