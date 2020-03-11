import 'dart:convert';

import 'package:crowdsourcing/common/MyPrimission.dart';
import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:crowdsourcing/models/object/Location.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class BaiduChannel {
  static const String _TencentChannel = "samples.flutter.io/Baidu";
  static const String _Locacation ="Location";
  static const platform = const MethodChannel(_TencentChannel);

  static void getLocation(BuildContext context,change) async {
    if(! await MyPrimission.getLocationPermission()){
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
            change(location);
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
