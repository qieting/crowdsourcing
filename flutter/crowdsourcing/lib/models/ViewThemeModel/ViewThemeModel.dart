import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../object/viewTheme.dart';
import 'ThemeHelper.dart';

class ViewThemeModel extends ChangeNotifier {
  static const String ViewThemeS = 'ViewTheme';
  ViewTheme _ViewTheme;

  ViewTheme get viewTheme => _ViewTheme;

  bool get hasViewTheme => ViewTheme != null;

  ViewThemeModel() {
    var s = StorageManager.localStorage.getItem(ViewThemeS);
    _ViewTheme = s == null ? ViewTheme() : ViewTheme.fromJsonMap(s);
    print(_ViewTheme.toJson());
  }

  saveViewTheme(ViewTheme ViewTheme) {
    _ViewTheme = ViewTheme;
    notifyListeners();
    StorageManager.localStorage.setItem(ViewThemeS, ViewTheme);
  }

  /// 清除持久化的用户数据
  clearViewTheme() {
    _ViewTheme = null;
    notifyListeners();
    StorageManager.localStorage.deleteItem(ViewThemeS);
  }

  //根据存储的对象生成对应的themedata，分为是否是黑暗模式
  ThemeData getTheme({platformDarkMode: false}) {
    //是否是黑夜模式取决于用户设置和系统设置
    var isDark = platformDarkMode || _ViewTheme.drakMode;
    //应用程序的整体主题亮度，利用这个判断文字的颜色
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;
    //根据下标获取相应的主题颜色
    var themeColor = Colors.primaries[_ViewTheme.themeColorIndex];

    //前景色（覆盖边缘效果）
    var accentColor = isDark ? themeColor[700] : themeColor[400];

    //生成这个themeData是为了获取到Brightness为dark下的appbar的主题
    var themeData = ThemeData(
        brightness: brightness,

        // 主题颜色属于亮色系还是属于暗色系(eg:dark时,AppBarTitle文字及状态栏文字的颜色为白色,反之为黑色)
        // 这里设置为dark目的是,不管App是明or暗,都将appBar的字体颜色的默认值设为白色.
        // 再AnnotatedRegion<SystemUiOverlayStyle>的方式,调整响应的状态栏颜色

        //primaryColor的亮度，用于设置在primaryColor上的文本的颜色
        primaryColorBrightness: Brightness.dark,
        //accentColor的亮度。用于确定位于accentColor上部的文本和图标颜色(例如，浮动操作按钮(FloatingButton)上的图标)
        accentColorBrightness: Brightness.dark,
        //主题颜色，这是一个颜色的相应的不同深度，比如primary通常为深度为500
        primarySwatch: themeColor,
        accentColor: accentColor,
        fontFamily: ViewTheme.FontValueList[_ViewTheme.fontindex]);

    //copywith  创建此文本主题的副本，但将给定字段替换为新值。
    themeData = themeData.copyWith(
      scaffoldBackgroundColor: isDark ? null : Colors.grey[100],
      brightness: brightness,
      accentColor: accentColor,
//      floatingActionButtonTheme:FloatingActionButtonThemeData(
//        backgroundColor: themeColor
//      ) ,

      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: themeColor,
        brightness: brightness,
      ),
      //elevation：提高  当为0时没有阴影
      appBarTheme: themeData.appBarTheme.copyWith(elevation: 0,
        color: isDark? null :themeColor[400]
      ),
      //启动界面
      splashColor: themeColor.withAlpha(50),
      hintColor: themeData.hintColor.withAlpha(90),
      errorColor: Colors.red,
      cursorColor: accentColor,
      textTheme: themeData.textTheme.copyWith(

          /// 解决中文hint不居中的问题 https://github.com/flutter/flutter/issues/40248
          subhead: themeData.textTheme.subhead
              .copyWith(textBaseline: TextBaseline.alphabetic)

      ),
      textSelectionColor: accentColor.withAlpha(60),
      textSelectionHandleColor: accentColor.withAlpha(60),
      toggleableActiveColor: accentColor,
      chipTheme: themeData.chipTheme.copyWith(
        pressElevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 10),
        labelStyle: themeData.textTheme.caption,
        backgroundColor: themeData.chipTheme.backgroundColor.withOpacity(0.1),
      ),
      //利用辅助类根据主题的颜色生成输入框主题
      inputDecorationTheme: ThemeHelper.inputDecorationTheme(themeData),
    );
    return themeData;
  }
}
