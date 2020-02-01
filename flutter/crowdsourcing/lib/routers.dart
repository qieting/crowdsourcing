import 'package:crowdsourcing/pages/MyHome/MyHomePage.dart';
import 'package:crowdsourcing/pages/login/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages/splash/splash.dart';

class Routers {
  static const String SPLASH = "splash";
  static const String MYHOMEPAGE = "myhomepage";
  static const String LOGIN = "login";

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
        return MyHomePage(title: params['title']);
        break;
      case LOGIN:
        return LoginPage();
        break;
      default:
        break;
    }
  }

//  Routers.pushNoParams(BuildContext context, String url) {
//    Navigator.push(context, MaterialPageRoute(builder: (context) {
//      return getPage(url,null);
//    }));
//  }

  Routers.push(BuildContext context, String url, {Map params}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return getPage(url, params: params);
    }));
  }
}
