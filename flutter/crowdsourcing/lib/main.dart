import 'dart:io';
import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/models/UserModel.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'i10n/localization_intl.dart';
import 'package:provider/provider.dart';

void main() {
  //storageMannager需要在app内部初始化
  //但是增加下面这句话就可以先初始化这个
  WidgetsFlutterBinding.ensureInitialized();
  StorageManager.init().then((val) {
    print("storage初始化成功");

    runApp(MyApp());
  });
  //设置安卓状态栏为透明,但是我感觉并没有必要
  if (false && Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserModel>(
            create: (context) => UserModel(),
          ),
        ],
        child: MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              DemoLocalizationsDelegate()
            ],
            localeResolutionCallback:(
                Locale locale, Iterable < Locale > supportedLocales)
            {
            if (locale == null) {
            debugPrint("*language locale is null!!!");
            return supportedLocales.first;
            }

            for (Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode ||
            supportedLocale.countryCode == locale.countryCode) {
            debugPrint("*language ok $supportedLocale");
            return supportedLocale;
            }
            }

            debugPrint("*language to fallback ${supportedLocales.first}");
            return supportedLocales.first;
            },
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('zh', 'CN')
            ],
            //routes: Routers.getRouters(),
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),

            //这个是对路径进行拦截，但是由于我们没设置router。因此是无效的

            onGenerateRoute: (RouteSettings settings) {
              String routeName = settings.name;
              print(routeName);
              return MaterialPageRoute(settings: settings);
//          return MaterialPageRoute(builder: (context) {
//            String routeName = settings.name;
//            print(routeName);
//            return  Route(settings: settings);
//
//            // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
//            // 引导用户登录；其它情况则正常打开路由。
//          });
            },
            home: Routers.getPage(Routers.SPLASH)
          //MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      );
  }
}
