import 'dart:convert';

import 'package:crowdsourcing/channel/QQChannel.dart';
import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:crowdsourcing/models/UserModel/LocationModel.dart';
import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:crowdsourcing/models/object/Location.dart';
import 'package:crowdsourcing/models/object/user.dart';
import 'package:crowdsourcing/net/MyUrl.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        User user = User.fromJsonMap(body['message']);
        Provider.of<UserModel>(context, listen: false).saveUser(user);
        List<Location> list   =json.decode(body['location']);
        Provider.of<LocationModel>(context, listen: false).addLocations(list);
        return true;
      } else {
        MyToast.toast(failStatus(response.statusCode));
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }


  }

  static changeMessage(Map map,BuildContext context) async {
    try {
      Response response = await dio.put(MyUrl.people, data: map);
      if (response.statusCode == 200) {
        var body = json.decode(response.toString());
        User user = User.fromJsonMap(body);
        Provider.of<UserModel>(context, listen: false).saveUser(user);
      } else {
        MyToast.toast(failStatus(response.statusCode));
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
        return DemoLocalizations.demoLocalizations.status401;
        break;
      case 417:
        return  DemoLocalizations.demoLocalizations.status407;
      case 500:
        return  DemoLocalizations.demoLocalizations.status500;
        break;
      default:
        return  DemoLocalizations.demoLocalizations.statusOhters + status.toString();
        break;
    }
  }

  static Login(Map map,
      {BuildContext context, Function success(), failed}) async {
    try{
      FocusScope.of(context).unfocus();
    Response response = await dio.post(MyUrl.people, data: map);
    if (response.statusCode == 200) {
      var body = json.decode(response.toString());
      if (body['status'] < 0) {
        Fluttertoast.showToast(msg:body['message']);
        failed();
        return;
      }
      token = body['token'];
      dio.options.headers[Token] = token;
      StorageManager.localStorage.setItem(Token, token);
      User user = User.fromJsonMap(body['message']);
      Provider.of<UserModel>(context, listen: false).saveUser(user);
      List<Location> list   =json.decode(body['location']);
      Provider.of<LocationModel>(context, listen: false).addLocations(list);
      if (body['register'] != null) {
        QQChannel.qqMessage();
      }
      Routers.pushAndRemove(context, Routers.MYHOMEPAGE,
          params: {"title": "as"});
    } else {
      failed();
      showError(context, failStatus(response.statusCode));
    }}catch (e){
      failed();
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
    }
  }
}

class UnTokenException implements Exception {
  const UnTokenException();

  @override
  String toString() => 'UnAuthorizedException';
}
