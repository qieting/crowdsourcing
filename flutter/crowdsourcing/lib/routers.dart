import 'package:crowdsourcing/pages/AddLocationPage.dart';
import 'package:crowdsourcing/pages/LocationPage.dart';
import 'package:crowdsourcing/pages/MessagePage/ChatPage.dart';
import 'package:crowdsourcing/pages/userMessage/ChangeMessage.dart';
import 'package:crowdsourcing/pages/MyHome/MyHomePage.dart';
import 'package:crowdsourcing/pages/MyOrderPage.dart';
import 'package:crowdsourcing/pages/NewOrderPage/NewOrderOnNet/AddOnlineStepPage.dart';
import 'package:crowdsourcing/pages/NewOrderPage/NewOrderOnNet/NewOrderOnNetPage.dart';
import 'package:crowdsourcing/pages/NewOrderPage/NewOrderOnOffline/NewOrderOnOffinePage.dart';
import 'package:crowdsourcing/pages/OffineOrdersPage.dart';
import 'package:crowdsourcing/pages/OrderOffineDetailsPage.dart';
import 'package:crowdsourcing/pages/OrderOnlineDetailsPage.dart';
import 'package:crowdsourcing/pages/OrderingDetails/OffineOrderingPage.dart';
import 'package:crowdsourcing/pages/OrderingDetails/OnlineOrderingPage.dart';
import 'package:crowdsourcing/pages/OtherOrderPage.dart';
import 'package:crowdsourcing/pages/PoiPage/PoiPage.dart';
import 'package:crowdsourcing/pages/checkPage.dart';
import 'package:crowdsourcing/pages/login/loginPage.dart';
import 'package:crowdsourcing/pages/settingPage.dart';
import 'package:crowdsourcing/pages/userMessage/MyMessage.dart';
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
  static const String OFFINEORDERSPAGE = 'OffineOrdersPage';
  static const String ADDONLINEPAGE = 'addOnlinStepePage';
  static const String ORDERONLINEDETAILSPAGE = 'OrderOnlineDetailsPage';
  static const String MYORDERPAGE = "MyOrderPage";
  static const String OFFINEORDERINGPAGE = "offineOrderPage";
  static const String ONLINEORDERINGPAGE = 'onlineOrderingPage';
  static const String CHECKPAGE = 'checkPage';
  static const String OTHERORDERPAGE = "otherorderpage";
  static const String SETTINGPAGE = "SETTINGpAGE";
  static const String MYMESSAGE = "MyMessage";
  static const String CHANGEMESSAGE = "CHANGEMESSAGE";
  static const String CHATPAGE ="chatpage";

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
      case ADDONLINEPAGE:
        return AddOnlineStepPage();
      case ORDERONLINEDETAILSPAGE:
        return OrderOnlineDetailsPage(
          onlineOrder: params["onlineOrder"],
          detail: params['detail'] ?? false,
          success: params['success'],
        );
      case MYORDERPAGE:
        return MyOrderPage(params['status']);
      case OFFINEORDERINGPAGE:
        return OffineOrderingPage(params['order']);
      case ONLINEORDERINGPAGE:
        return OnlineOrderingPage(params['order']);
      case CHECKPAGE:
        return CheckPage(params['ordering'], params['user'], params['order']);
      case OTHERORDERPAGE:
        return OtherOrderPage(params["status"], params['online']);
      case SETTINGPAGE:
        return SettingPage();
      case MYMESSAGE:
        return MyMessage();
      case CHANGEMESSAGE:
        return ChangeMessage(params['name']);
      case CHATPAGE:
        return ChatPage(params['id']);
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
