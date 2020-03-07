import 'dart:convert';

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
    try {
       platform.invokeMethod(_Locacation);
       platform.setMethodCallHandler((methodCall) async {
        switch (methodCall.method) {
          case _Locacation:
            String  status = await methodCall.arguments[_Locacation];

            Map<String, dynamic> map =  (json.decode(status));
            Location location =Location.fromJsonMap(map);
            change(location);
            break;

          default:
            throw MissingPluginException();
        }
      });
    } on PlatformException catch (e) {}
  }

}
