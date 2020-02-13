import 'dart:convert';

import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:crowdsourcing/models/object/user.dart';
import 'package:crowdsourcing/net/MyUrl.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class MyDio {
  static Dio dio;
  static const String Token = "token";

  static String token;

  static init() async {
    token = await StorageManager.localStorage.getItem(Token);
    dio = Dio(BaseOptions(
        connectTimeout: 3000,
        baseUrl: MyUrl.baseUrl,
        headers: token == null ? {} : {Token: token}));

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      if (!options.headers.containsKey(Token) &&
          !options.uri.toString().contains("people")) {
        throw UnTokenException();
      }
    }));
  }

  static getPeople(BuildContext context) async {
    try {
      Response response = await dio.get(MyUrl.people);
      if (response.statusCode == 200) {
        var body = json.decode(response.toString());
        User user = User.fromJsonMap(body);
        Provider.of<UserModel>(context, listen: false).saveUser(user);
        return true;
      } else {
        failStatus(response.statusCode);
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  static failStatus(int status) {
    switch (status) {
      case 200:
        return true;
        break;
      case 401:
        return "登陆状态无效，请登录";
        break;
      case 417:
        return "检测到异地登陆,请重新登陆";
      case 500:
        return "服务器发射管异常错误";
        break;
      default:
        return "网络连接异常，错误码" + status.toString();
        break;
    }
  }

  static Login(Map map,
      {BuildContext context, Function success(), Function failed()}) async {
    Response response = await dio.post(MyUrl.people, data: map);
    if (response.statusCode == 200) {
      var body = json.decode(response.toString());
      if (body['status'] < 0) {
        MyToast.toast(body['message']);
        return;
      }
      token = body['token'];
      dio.options.headers[Token] = token;
      //StorageManager.localStorage.setItem(Token, token);
      User user = User.fromJsonMap(body['message']);
      Provider.of<UserModel>(context,listen: false).saveUser(user);
      Routers.pushAndRemove(context, Routers.MYHOMEPAGE,params: {"title":"as"});
    } else {
      failStatus(response.statusCode);
    }
  }
}

class UnTokenException implements Exception {
  const UnTokenException();

  @override
  String toString() => 'UnAuthorizedException';
}
