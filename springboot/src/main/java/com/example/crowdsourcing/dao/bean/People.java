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
    private int id;

    @Column(name = "number", unique = true)
    private String number;

    @Column(name = "pass_word")
    private String password;

    @Column(name = "weixin", unique = true)
    private String weixin;

    @Column(name = "qq", unique = true)
    private String qq;

    @Column(updatable = false)
    private Date date = new Date();

    @Column
    private String head;

    @Column
    private String gender;

    @Column
    private String nick;

    @Column
    private  double money;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    @Column
    private String token ;



    public double getMoney() {
        return money;
    }

    public void setMoney(double money) {
        this.money = money;
    }

    public People() {
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }




    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getHead() {
        return head;
    }

    public void setHead(String head) {
        this.head = head;
    }

    public String getNick() {
        return nick;
    }

    public void setNick(String nick) {
        this.nick = nick;
    }


    @Override
    public String toString() {
        return id + "," + number + "," + password + ',' + weixin + "," + qq;
    }

    ;

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


    public void change(People people) {
        if (people.getNick() != null) {
            this.setNick(people.getNick());
        }
        if(people.getMoney()!=0){
            this.setMoney(people.getMoney());
        }
        if (people.getHead() != null) {
            this.setHead(people.getHead());
        }
        if (people.getGender() != null) {
            this.setGender(people.getGender());
        }
        if (people.getQq() != null) {
            this.setQq(people.getQq());
        }
        if (people.getWeixin() != null) {
            this.setWeixin(people.getWeixin());
        }
        if (people.getNumber() != null) {
            this.setNumber(people.getNumber());
        }
    }

    public void addMoney(double money){
        this.money+=money;
    }

    public void minusMoney(double money){
        this.money-=money;
    }

}
