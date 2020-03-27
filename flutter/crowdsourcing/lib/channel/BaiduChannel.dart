import 'dart:convert';

import 'package:crowdsourcing/common/MyPrimission.dart';
import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:crowdsourcing/models/object/order/offine/location/Location.dart';
import 'package:crowdsourcing/models/object/order/offine/location/MyPoi.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class BaiduChannel {
  static const String _TencentChannel = "samples.flutter.io/Baidu";
  static const String _Locacation ="Location";
  static const platform = const MethodChannel(_TencentChannel);
  static Location _location;
  static const String  _Poi = "poi";
  static const String City ="CITY";
  static const String Keyword ="KEYWORD";

  static var _changePoi;

  static void getPois(String city ,String keyWord, changePio)async {
    if(_changePoi==null)
    _changePoi =changePio;
    platform.invokeMethod(_Poi,{City:city,Keyword:keyWord});
  }


  static void getLocation(change) async {
    if(_location!=null){
      change(_location);
      return;
    }else
    if(! await MyPrimission.getLocationPermission()){
      MyToast.toast("您没有开启定位功能，请开启位置定位");
      return;
    }
    try {
       platform.invokeMethod(_Locacation);
       platform.setMethodCallHandler((methodCall) async {
        switch (methodCall.method) {
          case _Locacation:
            String  status = await methodCall.arguments[_Locacation];

            Map<String, dynamic> map =  (json.decode(status));
            Location location =Location.fromJsonMap(map);
            if(location.province==null){
              MyToast.toast("您没有开启定位功能，请开启位置定位");
              return ;
            }
            _location=location;
            change(location);
            break;
          case _Poi:
            String status = await methodCall.arguments[_Poi];
             var pois = json.decode(status);
             List<Location> mypois = [];
             for(var poi in pois){
               mypois.add(Location.fromJsonMap(poi));
             }
             if(_changePoi!=null){
               _changePoi(mypois);
             }

//            Map<String, dynamic> map =  (json.decode(status));
//            Location location =Location.fromJsonMap(map);
//            if(location.province==null){
//              MyToast.toast("您没有开启定位功能，请开启位置定位");
//              return ;
//            }
//            _location=location;
//            change(location);
            break;

          default:
            throw MissingPluginException();
        }
      });
    } on PlatformException catch (e) {
      print(e.details);
    }
  }

}
