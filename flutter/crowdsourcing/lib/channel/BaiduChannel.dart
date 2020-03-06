import 'dart:convert';

import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class BaiduChannel {
  static const String _TencentChannel = "samples.flutter.io/Baidu";
  static const String _Locacation ="Location";
  static const platform = const MethodChannel(_TencentChannel);

  static void getLocation(BuildContext context) async {
    try {
       platform.invokeMethod(_Locacation);
      platform.setMethodCallHandler((methodCall) async {
        switch (methodCall.method) {
          case _Locacation:
            String  status = methodCall.arguments[_Locacation];
            MyToast.toast(status);
            break;

          default:
            throw MissingPluginException();
        }
      });
    } on PlatformException catch (e) {}
  }

}
