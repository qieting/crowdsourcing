import 'package:crowdsourcing/pages/AddLocationPage.dart';
import 'package:crowdsourcing/pages/LocationPage.dart';
import 'package:crowdsourcing/pages/MyHome/MyHomePage.dart';
import 'package:crowdsourcing/pages/NewOrderPage/NewOrderOnNet/NewOrderOnNetPage.dart';
import 'package:crowdsourcing/pages/NewOrderPage/NewOrderOnOffline/NewOrderOnOffinePage.dart';
import 'package:crowdsourcing/pages/OffineOrdersPage.dart';
import 'package:crowdsourcing/pages/OrderOffineDetailsPage.dart';
import 'package:crowdsourcing/pages/PoiPage/PoiPage.dart';
import 'package:crowdsourcing/pages/login/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages/NewOrderPage/NewOrderOnOffline/OnOffineAddpage.dart';
import 'pages/splash/splash.dart';

class Routers {
  static const String SPLASH = "splash";
  static const String MYHOMEPAGE = "myhomepage";
  static const String LOGIN = "login";
  static const String NEWORDERONNET = "net";
  static const String NEWODERONOFFLINE = "offline";
  static const String OnOfficeAdd = "onAddOfficeAddpage";
  static const String LOCATIONPAGE = "LocationPage";
  static const String ADDLOcationPage = "AddLocationPage";
  static const String POIPAGE = "poipage";
  static const String ORDEROFFINEDETAILPAGE = 'OrderOffineDetailsPage';
  static const String OFFINEORDERSPAGE ='OffineOrdersPage';

  //此处有过一次错误，当时想将weight直接存入map，但是存在一些问题：
  //①有些组件需要参数
  //②换为type存入，但是不支持反射，根据type生成对象（并且效率问题也存在）
//  static Map<String, Weight> routermap = {
//    SPLASH: SplashPage,
//    MYHOMEPAGE: MyHomePage
//  };
//
//  static getRouters() {
//    return routermap.map((String key, Type value) {
//      switch (key) {
//        default:
//          {
//            return new MapEntry(key, (context) => (value));
//          }
//          break;
//      }
//    });
//  }

  static getPage(String s, {Map params}) {
    switch (s) {
      case SPLASH:
        return SplashPage();
        break;
      case MYHOMEPAGE:
        return MyHomePage();
        break;
      case LOGIN:
        return LoginPage();
        break;
      case NEWODERONOFFLINE:
        return NewOrderOnOffline();
        break;
      case NEWORDERONNET:
        return NewOrderOnNet();
        break;
      case OnOfficeAdd:
        return OnOfficeAddpage();
        break;
      case LOCATIONPAGE:
        return LocationPage(
          choose: params == null ? null : params["location"],
        );
      case ADDLOcationPage:
        return AddLocationPage();
      case POIPAGE:
        return PoiPage(
          city: params['city'],
        );
      case ORDEROFFINEDETAILPAGE:
        return OrderOffineDetailsPage(
          offineOrder: params["offineOrder"],
          detail: params['detail'] ?? false,
          success: params['success'],
        );
      case OFFINEORDERSPAGE:
        return OffineOrdersPage();
      default:
        break;
    }
  }

//  Routers.pushNoParams(BuildContext context, String url) {
//    Navigator.push(context, MaterialPageRoute(builder: (context) {
//      return getPage(url,null);
//    }));
//  }

  static Future<Map> push(BuildContext context, String url,
      {Map params}) async {
    return await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return getPage(url, params: params);
    }));
  }

  static pushAndRemove(BuildContext context, String url, {Map params}) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      //这里根据是否有user进行不同的跳转
      return getPage(url, params: params);
    }), (route) => route == null);
  }

  static Future<T> pushForResult<T>(BuildContext context, String url,
      {Map params}) async {
    return await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return getPage(url, params: params);
    }));
  }
}
