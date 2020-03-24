package com.example.crowdsourcing.model

import com.google.gson.Gson

data class Location(val province: String, val city: String, val street: String?=null, val plot: String? = null, val town: String? = null, val others: String, val name: String? = null) {
    override fun toString(): String {
        return Gson().toJson(this);
    }
}