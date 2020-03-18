package com.example.crowdsourcing.model;

import com.google.gson.Gson;

public class Location {
    private static final long serialVersionUID = 1L;




    private String province;

    private String  city;

    private String  street;

    private String  others;

    private String plot;
    private  String town;



    public Location(){

    }




    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getOthers() {
        return others;
    }

    public void setOthers(String others) {
        this.others = others;
    }


    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getPlot() {
        return plot;
    }

    public void setPlot(String plot) {
        this.plot = plot;
    }


    public  String toString(){
        return  new Gson().toJson(this);
    }


    public String getTown() {
        return town;
    }

    public void setTown(String town) {
        this.town = town;
    }
}
