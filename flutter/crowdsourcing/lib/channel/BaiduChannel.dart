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
  static const String _Locacation = "Location";
  static const String _Poi = "poi";
  static const String City = "CITY";
  static const String Keyword = "KEYWORD";

  static MethodChannel platform;

  static Location _location;

  static Function _changePoi;

  //进行poi搜索，changePio用于获取到poi后的操作
  static void getPois(String city, String keyWord, Function changePio) async {
    if (_changePoi == null) _changePoi = changePio;
    platform.invokeMethod(_Poi, {City: city, Keyword: keyWord});
  }

  //夺取定位信息
  static void getLocation(Function change) async {
    if (platform == null) {
      platform = MethodChannel(_TencentChannel);
    }
    if (_location != null) {
      change(_location);
      return;
    } else if (!await MyPrimission.getLocationPermission()) {
      MyToast.toast(DemoLocalizations.demoLocalizations.locationNoPermisson);
      return;
    }
    try {
      //让原生代码获取定位信息
      platform.invokeMethod(_Locacation);
      platform.setMethodCallHandler((methodCall) async {
        switch (methodCall.method) {
          case _Locacation:
            String status = await methodCall.arguments[_Locacation];
            Map<String, dynamic> map = (json.decode(status));
            Location location = Location.fromJsonMap(map);
            if (location.province == null) {
              MyToast.toast(DemoLocalizations.demoLocalizations.locationNoMessage);
              return;
            }
            _location = location;
            change(location);
            break;
          case _Poi:
            String status = await methodCall.arguments[_Poi];
            var pois = json.decode(status);
            List<Location> mypois = [];
            for (var poi in pois) {
              mypois.add(Location.fromJsonMap(poi));
            }
            if (_changePoi != null) {
              _changePoi(mypois);
            }
            break;
          default:
            throw MissingPluginException();
        }
      });
    } on PlatformException catch (e) {
      MyToast.toast(DemoLocalizations.demoLocalizations.bug);
      print(e.details);
    }
  }
}
