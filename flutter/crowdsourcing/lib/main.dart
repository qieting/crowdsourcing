import 'dart:io';
import 'package:crowdsourcing/common/BmobMessage.dart';
import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/models/OrderModel/OffineOrderModel.dart';
import 'package:crowdsourcing/models/OrderModel/OffineOrderingModel.dart';
import 'package:crowdsourcing/models/OrderModel/OnlineOrderModel.dart';
import 'package:crowdsourcing/models/OrderModel/OnlineOrderingModel.dart';
import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:crowdsourcing/models/ViewThemeModel/ViewThemeModel.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'i10n/localization_intl.dart';
import 'package:provider/provider.dart';
import 'models/UserModel/LocationModel.dart';

void main() {
  //storageMannager需要在app内部初始化
  //但是增加下面这句话就可以先初始化这个
  WidgetsFlutterBinding.ensureInitialized();
  StorageManager.init().then((val) {
    //storagemanager初始化大约需要1.2秒
    runApp(MyApp());
    MyDio.init();
  });
  //设置安卓状态栏为透明
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //此处的provider并不会立刻生成，而是会在第一次使用的地方初始化
      //初始化的分别为，用户，主题，位置，离线订单接单信息，离线订单发布信息，在线订单发布信息，在线订单接单信息
      providers: [
        ChangeNotifierProvider<UserModel>(
          create: (context) => UserModel(),
        ),
        ChangeNotifierProvider<ViewThemeModel>(
          create: (context) => ViewThemeModel(),
        ),
        ChangeNotifierProvider<LocationModel>(
          create: (context) => LocationModel(),
        ),
        ChangeNotifierProvider<OffineOrderingModel>(
          create: (context) => OffineOrderingModel(),
        ),
        ChangeNotifierProvider<OffineOrderModel>(
          create: (context) => OffineOrderModel(),
        ),
        ChangeNotifierProvider<OnlineOrderModel>(
          create: (context) => OnlineOrderModel(),
        ),
        ChangeNotifierProvider<OnlineOrderingModel>(
          create: (context) => OnlineOrderingModel(),
        ),
      ],
      child: Consumer<ViewThemeModel>(builder: (context, viewThemeMode, child) {
        //根据是否黑暗模式设置通知栏字体颜色（比如白天由于背景是白色，字体需要变为黑色）
        return AnnotatedRegion<SystemUiOverlayStyle>(
          //value: SystemUiOverlayStyle.dark,
          value: !viewThemeMode.viewTheme.drakMode
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          child: MaterialApp(
              onGenerateTitle: (context){
                // 此时context在Localizations的子树中
                return DemoLocalizations.of(context).title;
              },
              builder: (context, child) {
                //初始化语言包
                DemoLocalizations.init(context);
                return child;
              },
              //showPerformanceOverlay: true,
              debugShowCheckedModeBanner: false,
              theme: viewThemeMode.getTheme(),
              darkTheme: viewThemeMode.getTheme(platformDarkMode: true),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                DemoLocalizationsDelegate()
              ],
              localeResolutionCallback:
                  (Locale locale, Iterable<Locale> supportedLocales) {
                //当没有支持语言时，返回英语。
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
              //支持的语言
              supportedLocales: [
                const Locale('en', 'US'),
                const Locale('zh', 'CN')
              ],
              //这个是对路径进行拦截，但是由于我们没设置router。因此是无效的
              onGenerateRoute: (RouteSettings settings) {
                String routeName = settings.name;
                print(routeName);
                return MaterialPageRoute(settings: settings);
              },
              home: Routers.getPage(Routers.SPLASH)
              //MyHomePage(title: 'Flutter Demo Home Page'),
              ),
        );
      }),
    );
  }
}
