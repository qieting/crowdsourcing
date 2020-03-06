package com.example.crowdsourcing;


import android.app.Application;

import com.baidu.mapapi.CoordType;
import com.baidu.mapapi.SDKInitializer;

import io.flutter.app.FlutterApplication;

public class App extends FlutterApplication {

    @Override
    public void onCreate() {
        super.onCreate();
//        SDKInitializer.initialize(this);
//        SDKInitializer.setCoordType(CoordType.BD09LL);
    }
}
