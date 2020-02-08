import 'package:crowdsourcing/common/MyThemes.dart';
import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //唯一性表示form
  GlobalKey globalKey = new GlobalKey();
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();

  //记录当前输入框的颜色
  int i = 0;

  //因为检验时如果错误会导致一直显示报错，因此
  //设置变量保证，当输入的时候是正确的
  bool isinput = true;
  Color userNameColor;
  Color pwdColor;

  //是否隐藏密码
  bool obscureText = true;

  String userNameValidator(String value) {
    if (isinput) return null;
    if (value.length < 11) {
      return DemoLocalizations.of(context).errorPhoneNumberLength;
    } else {
      RegExp mobile = new RegExp(r"1[0-9]\d{9}$");
      if (mobile.hasMatch(value)) {
        return DemoLocalizations.of(context).errorPhoneNumberReg;
      }
    }
  }

  String pwdValidator(String value) {
    if (!isinput) {
      if (value.trim().length < 8) {
        return DemoLocalizations.of(context).errorPwdLenth;
      } else {
        RegExp pwd = new RegExp(r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$");
        if (pwd.hasMatch(value)) {
          return DemoLocalizations.of(context).errorPwdReg;
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode1.addListener(() {
      if (focusNode1.hasFocus) {
        setState(() {
          i = ++i % 7;
          userNameColor = Rainbows[6 - i];
        });
      } else {
        setState(() {
          userNameColor = Theme.of(context).primaryColor;
        });
      }
    });
    focusNode2.addListener(() {
      if (focusNode2.hasFocus) {
        setState(() {
          i = ++i % 7;
          pwdColor = Rainbows[6 - i];
        });
      } else {
        setState(() {
          pwdColor = Theme.of(context).primaryColor;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //监听获取焦点，实现在切换焦点时label和border颜色同步

    userNameColor = userNameColor??Theme.of(context).primaryColor;
    pwdColor =pwdColor?? Theme.of(context).primaryColor;
    return Scaffold(
      //backgroundColor:  Theme.of(context).primaryColor,
      //不根据弹出输入框重绘，这样将输入框尽量往上放
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 150),
        child: Container(
          child: Form(
            autovalidate: true,
            key: globalKey,
            child: Column(
              //direction: Axis.horizontal,

              //纵轴对其方式
              //crossAxisAlignment: CrossAxisAlignment.center,
              //主轴对齐方式
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _unameController,
                  keyboardType: TextInputType.number,
                  focusNode: focusNode1,
                  maxLength: 11,
                  //当长度超过最大长度时是否阻止继续输入
                  maxLengthEnforced: true,
//   感觉进去就弹出输入法体验很差，所以不自动获得焦点
//                    autofocus: true,
                  //对输入进行检验，不返回值代表没有问题
                  validator: userNameValidator,
                  //设置输入光标样式
                  cursorRadius: Radius.circular(8),
                  cursorWidth: 4,
                  cursorColor: Rainbows[i],
                  onChanged: (value) {
                    //监听输入变化，改变光标颜色
                    setState(() {
                      i = ++i % 7;
                      userNameColor = Rainbows[6 - i];
                      pwdColor = Theme.of(context).primaryColor;
                    });
                    print("$i");
                  },
                  //正在编辑的字体的颜色
                  style: TextStyle(color:userNameColor),
                  decoration: InputDecoration(
                    //删除按钮，由于是一个组件，因此我们可以放很多东西
                    suffixIcon:
                        focusNode1.hasFocus && _unameController.text.length > 0
                            ? IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: userNameColor,
                                ),
                                onPressed: () {
                                  //如果直接清空会报错，因为需要先失去焦点再清空数据
                                  //保证在组件build的第一帧时才去触发取消清空内容
                                  WidgetsBinding.instance.addPostFrameCallback(
                                      (_) => _unameController.clear());
                                },
                              )
                            : null,
                    fillColor: Colors.grey[100],
                    filled: true,
                    //设置获取焦点时颜色
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Rainbows[6 - i], width: 3),
                      borderRadius: BorderRadius.circular(55),
                    ),
                    //失去焦点时颜色
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(55),
                    ),
                    //当validator报错时上面两种显示都会失效，所以必须设置默认显示
                    //但是此时只有弧度生效，颜色和宽度并没有生效
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(55),
                        borderSide: BorderSide(color: Rainbows[i], width: 55)
                        //borderSide: BorderSide.none
                        ),
                    labelText: DemoLocalizations.of(context).phoneNumber,
                    hintText: DemoLocalizations.of(context).phoneNumberEnter,
                    labelStyle: TextStyle(color: userNameColor),
                    //开始图标
                    prefixIcon: Icon(
                      Icons.person,
                      color: userNameColor,
                    ),
                  ),
                ),
                TextFormField(
                  focusNode: focusNode2,
                  controller: _pwdController,
                  textInputAction: TextInputAction.done,
                  obscureText: obscureText,
                  maxLength: 16,
                  maxLengthEnforced: true,
                  style: TextStyle(color:pwdColor),
                  //设置输入光标样式
                  cursorRadius: Radius.circular(8),
                  cursorWidth: 4,
                  cursorColor: Rainbows[i],
                  onChanged: (value) {
                    //监听输入变化，改变光标颜色
                    setState(() {
                      i = ++i % 7;
                      pwdColor = Rainbows[6 - i];
                      userNameColor = Theme.of(context).primaryColor;
                    });
                    print("$i");
                  },
                  validator: pwdValidator,
                  decoration: InputDecoration(
                      suffixIcon: focusNode2.hasFocus &&
                              _pwdController.text.length > 0
                          ? Container(
                              width: 100,
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    padding: const EdgeInsets.all(0.0),
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: pwdColor,
                                    ),
                                    onPressed: () {
                                      //如果直接清空会报错，因为需要先失去焦点再清空数据
                                      //保证在组件build的第一帧时才去触发取消清空内容
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    padding: const EdgeInsets.all(0.0),
                                    icon: Icon(
                                      Icons.delete,
                                      color: pwdColor,
                                    ),
                                    onPressed: () {
                                      //如果直接清空会报错，因为需要先失去焦点再清空数据
                                      //保证在组件build的第一帧时才去触发取消清空内容
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                              (_) => _pwdController.clear());
                                    },
                                  ),
                                ],
                              ),
                            )
                          : null,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Rainbows[6 - i], width: 3),
                        borderRadius: BorderRadius.circular(55),
                      ),
                      //失去焦点时颜色
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(55),
                      ),
                      //当validator报错时上面两种显示都会失效，所以必须设置默认显示
                      //但是此时只有弧度生效，颜色和宽度并没有生效
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(55),
                          borderSide: BorderSide(color: Rainbows[i], width: 55)
                          //borderSide: BorderSide.none
                          ),
                      fillColor: Colors.grey[100],
                      filled: true,
                      labelText: DemoLocalizations.of(context).password,
                      hintText: DemoLocalizations.of(context).passwordEnter,
                      labelStyle: TextStyle(color: pwdColor),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: pwdColor,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            isinput = false;
                            if ((globalKey.currentState as FormState)
                                .validate()) {
                              //验证通过提交数据
                              isinput = true;
                              var username = _unameController.text;
                              var password = _pwdController.text;
                              print("$username,$password");
                            } else {
                              Future.delayed(Duration(seconds: 1), () {
                                setState(() {
                                  isinput = true;
                                });
                              });
                            }
                          },
                          child: Text(DemoLocalizations.of(context).login),
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//
//mixin LoginAction on State<LoginPage> {
//
//
//}
