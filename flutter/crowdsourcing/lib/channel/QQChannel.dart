import 'dart:convert';

import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/pages/MyHome/MyHomePage.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class QQChannel {
  static const String _TencentChannel = "samples.flutter.io/QQ";
  static const String _QQinstalled = "QQinstalled";
  static const String _QQLogin = "loginByQQ";
  static const String _QQMessage = "QQMessage";
  static const String LoginStstus = "ret";
  static const String ARGUMENT_KEY_RESULT_MSG = "msg";
  static const String ARGUMENT_KEY_RESULT_OPENID = "openid";
  static const String ARGUMENT_KEY_RESULT_ACCESS_TOKEN = "access_token";
  static const String ARGUMENT_KEY_RESULT_EXPIRES_IN = "expires_in";
  static const String ARGUMENT_KEY_RESULT_CREATE_AT = "create_at";

  static const int QQLoginCancel = -1;
  static const int QQLoginSuccess = -2;
  static const int QQLoginError = -3;

  static MethodChannel platform;

  //qq登录
  static Future<String> loginByQQ(BuildContext context) async {
    try {
      await platform.invokeMethod(_QQLogin);
      platform.setMethodCallHandler((methodCall) async {
        switch (methodCall.method) {
          case _QQLogin:
            int status = await methodCall.arguments[LoginStstus];
            String message =
                await methodCall.arguments[ARGUMENT_KEY_RESULT_MSG];
            switch (status) {
              case QQLoginCancel:
                MyToast.toast(DemoLocalizations.demoLocalizations.loginCancel);
                break;
              case QQLoginError:
                MyToast.toast(
                    DemoLocalizations.demoLocalizations.err + message);
                break;
              case QQLoginSuccess:
                print(message);
                Map<String, dynamic> user = json.decode(message);
                MyDio.Login(
                    new Map<String, dynamic>.from({'qq': user["openid"]}),
                    context: context);
                break;
              default:
                break;
            }
            break;
          case _QQMessage:
            int status = await methodCall.arguments[LoginStstus];
            String message =
                await methodCall.arguments[ARGUMENT_KEY_RESULT_MSG];
            switch (status) {
              case QQLoginCancel:
                MyToast.toast(
                    DemoLocalizations.demoLocalizations.userInfoFailed);
                break;
              case QQLoginError:
                MyToast.toast(
                    DemoLocalizations.demoLocalizations.userInfoError +
                        message);
                break;
              case QQLoginSuccess:
                Map<String, dynamic> _qquser = json.decode(message);
                _qquser["nick"] = _qquser["nickname"];
                _qquser["head"] = _qquser["figureurl_2"];
                print(_qquser);
                await MyDio.changeMessage(_qquser);
                break;
              default:
                break;
            }
            break;
          default:
            throw MissingPluginException();
        }
      });
    } on PlatformException catch (e) {
      MyToast.toast(e.message);
    }
  }

  //获取是否安装qq系数据
  static Future<bool> qqAppInstalled() async {
    bool installed = false;
    platform = const MethodChannel(_TencentChannel);
    try {
      installed = await platform.invokeMethod(_QQinstalled);
    } on PlatformException catch (e) {
      MyToast.toast(e.message);
    }
    return installed;
  }

  //获取QQ个人信息
  static Future<Null> qqMessage() async {
    try {
      platform.invokeMethod(_QQMessage);
    } on PlatformException catch (e) {
      MyToast.toast(e.message);
    }
  }
}
