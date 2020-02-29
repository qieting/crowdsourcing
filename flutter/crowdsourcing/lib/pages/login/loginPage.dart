import 'dart:async';


import 'package:crowdsourcing/channel/QQChannel.dart';
import 'package:crowdsourcing/common/BmobMessage.dart';
import 'package:crowdsourcing/common/MyImages.dart';
import 'package:crowdsourcing/common/MyThemes.dart';
import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //唯一性表示form
  GlobalKey globalKey = new GlobalKey();
  bool QQInstalled = false;

  bool byPassword = false;

  //记录当前输入框的颜色
  int i = 1;

  //因为检验时如果错误会导致一直显示报错，因此
  //设置变量保证，当输入的时候是正确
  //设置变量保证，当输入的时候是正确
  bool isinput = true;

  //是否隐藏密码
  bool obscureText = true;

  //用来记录短信验证码状
  int nextTime = -1;

  String messageText = DemoLocalizations.demoLocalizations.messagText(0);

  //
  //String loginWay ;

  bool logining = false;

//  Color userNameColor;
//  Color pwdColor;
  Color userNameColor;
  Color pwdColor;

  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  TextEditingController _messageController = new TextEditingController();

  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusNode focusNode3 = new FocusNode();
  Timer timer;

  @override
  dispose() {
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }

  String userNameValidator(String value) {
    if (isinput) return null;
    if (value.length < 11) {
      return DemoLocalizations.of(context).errorPhoneNumberLength;
    } else {
      RegExp mobile = new RegExp(r"1[0-9]{10}$");
      //print(value+value.length.toString());
      if (!mobile.hasMatch(value)) {
        return DemoLocalizations.of(context).errorPhoneNumberReg;
      }
    }
  }

  String pwdValidator(String value) {
    if (!isinput) {
      if (value.trim().length < 8) {
        return DemoLocalizations.of(context).errorPwdLenth;
      } else {
        RegExp pwd = new RegExp(r"[0-9A-Za-z]{8,16}$");
        //print(value+value.length.toString());
        if (!pwd.hasMatch(value)) {
          return DemoLocalizations.of(context).errorPwdReg;
        }
      }
    }
  }

  loginByQQ() async {
    QQChannel.loginByQQ(context);
  }

  startTimer() {
    timer = new Timer(new Duration(seconds: 1), () {
      if (nextTime > 0) {
        setState(() {
          nextTime--;
          messageText = DemoLocalizations.of(context).messagText(nextTime);
          ;
        });

        startTimer();
      } else {
        setState(() {
          messageText = DemoLocalizations.of(context).messagText(0);
          ;
        });
      }
    });
  }

  getMessage() {
    nextTime = 60;
    startTimer();
    BmobMessage.sendSms(context, _unameController.text, () {});
  }

  String messageValidator(String value) {
    if (!isinput) {
      if (value.trim().length != 6) {
        return DemoLocalizations.of(context).messageErr;
      } else {
        RegExp mobile = new RegExp(r"[0-9]{6}$");
        //print(value+value.length.toString());
        if (!mobile.hasMatch(value)) {
          return DemoLocalizations.of(context).messageErr;
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    focusNode1.addListener(() {
//      if (focusNode1.hasFocus) {
//        setState(() {
//          i = ++i % 7;
//          userNameColor = Rainbows[6 - i];
//        });
//      } else {
//        setState(() {
//          userNameColor = Theme.of(context).primaryColor;
//        });
//      }
//    });
//    focusNode2.addListener(() {
//      if (focusNode2.hasFocus) {
//        setState(() {
//          i = ++i % 7;
//          pwdColor = Rainbows[6 - i];
//        });
//      } else {
//        setState(() {
//          pwdColor = Theme.of(context).primaryColor;
//        });
//      }
//    });
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
//    focusNode3.addListener(() {
//      if (focusNode3.hasFocus) {
//        setState(() {
//          i = ++i % 7;
//          pwdColor = Rainbows[6 - i];
//        });
//      } else {
//        setState(() {
//          pwdColor = Theme.of(context).primaryColor;
//        });
//      }
//    });
    QQChannel.qqAppInstalled().then((value) {
      setState(() {
        QQInstalled = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //监听获取焦点，实现在切换焦点时label和border颜色同步
//    userNameColor = userNameColor ?? Theme.of(context).primaryColor;
//    pwdColor = pwdColor ?? Theme.of(context).primaryColor;
    userNameColor = userNameColor ?? Theme.of(context).primaryColor;
    pwdColor = pwdColor ?? Theme.of(context).primaryColor;
    return Scaffold(
      //backgroundColor:  Theme.of(context).primaryColor,
      //不根据弹出输入框重绘，这样将输入框尽量往上放
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 150, 40, 80),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
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
                      //对输入进行检验，不返回值代表没有问
                      validator: userNameValidator,
                      //设置输入光标样式
                      cursorRadius: Radius.circular(8),
                      cursorWidth: 4,

                      cursorColor: Rainbows[i],
                      onChanged: (value) {
                        //监听输入变化，改变光标颜
                        setState(() {
                          i = ++i % 7;
                          userNameColor = Rainbows[6 - i];
                          pwdColor = Theme.of(context).primaryColor;
                        });
                        if (nextTime == -1 || nextTime == 0) {
                          if (value.length == 11 && value.startsWith("1")) {
                            nextTime = 0;
                          } else {
                            nextTime = -1;
                          }
                        }

                        print("$i");
                      },
                      //正在编辑的字体的颜色
                      style: TextStyle(color: userNameColor),
                      decoration: InputDecoration(
                        //删除按钮，由于是一个组件，因此我们可以放很多东
                        suffixIcon: focusNode1.hasFocus &&
                                _unameController.text.length > 0
                            ? IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: userNameColor,
                                ),
                                onPressed: () {
//                                  //如果直接清空会报错，因为需要先失去焦点再清空数
//                                  //保证在组件build的第一帧时才去触发取消清空内容
//                                  WidgetsBinding.instance.addPostFrameCallback(
//                                      (_) => _unameController.clear());
                                  _unameController.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                        fillColor: Colors.grey[100],
                        filled: true,
                        //设置获取焦点时颜
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Rainbows[6 - i], width: 3),
                          borderRadius: BorderRadius.circular(55),
                        ),
                        //失去焦点时颜
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.0),
                          borderRadius: BorderRadius.circular(55),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(55),
                            borderSide: BorderSide(
                                color: Theme.of(context).errorColor, width: 3)
                            //borderSide: BorderSide.none
                            ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(55),
                            borderSide: BorderSide(
                                color: Theme.of(context).errorColor, width: 3)
                            //borderSide: BorderSide.none
                            ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(55),
                            borderSide: BorderSide(color: Rainbows[i], width: 3)
                            //borderSide: BorderSide.none
                            ),
                        labelText: DemoLocalizations.of(context).phoneNumber,
                        hintText:
                            DemoLocalizations.of(context).phoneNumberEnter,
                        labelStyle: TextStyle(color: userNameColor),
                        //开始图
                        prefixIcon: Icon(

                          Icons.person,
                          color: userNameColor,
                        )
                      ),
                    ),
                    !byPassword
                        ? Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: TextFormField(
                                      focusNode: focusNode3,
                                      controller: _messageController,
                                      textInputAction: TextInputAction.done,
                                      maxLength: 6,
                                      keyboardType: TextInputType.number,
                                      maxLengthEnforced: true,
                                      style: TextStyle(
                                          color: pwdColor, letterSpacing: 1),
                                      //设置输入光标样式
                                      cursorRadius: Radius.circular(8),
                                      cursorWidth: 4,
                                      cursorColor: Rainbows[i],
                                      onChanged: (value) {
                                        //监听输入变化，改变光标颜
                                        setState(() {
                                          i = ++i % 7;
                                          pwdColor = Rainbows[6 - i];
                                          userNameColor =
                                              Theme.of(context).primaryColor;
                                        });
                                      },
                                      validator: messageValidator,
                                      decoration: InputDecoration(
                                          suffixIcon: focusNode3.hasFocus &&
                                                  _messageController.text.length >
                                                      0
                                              ? Container(
                                                  margin:
                                                      const EdgeInsets.all(0),
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  width: 30,
                                                  child: IconButton(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    icon: Icon(
                                                      Icons.delete,
                                                      size: 24,
                                                      color: pwdColor,
                                                    ),
                                                    onPressed: () {
                                                      //如果直接清空会报错，因为需要先失去焦点再清空数
                                                      //保证在组件build的第一帧时才去触发取消清空内容

                                                      _messageController
                                                          .clear();
                                                      setState(() {});
                                                    },
                                                  ))
                                              : null,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Rainbows[6 - i],
                                                width: 3),
                                            borderRadius:
                                                BorderRadius.circular(55),
                                          ),
                                          //失去焦点时颜
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(55),
                                          ),
                                          //当validator报错时上面两种显示都会失效，所以必须设置默认显
                                          //但是此时只有弧度生效，颜色和宽度并没有生
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(55),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                  width: 3)
                                              //borderSide: BorderSide.none
                                              ),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(55),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                  width: 3)
                                              //borderSide: BorderSide.none
                                              ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(55),
                                              borderSide: BorderSide(
                                                  color: Rainbows[i], width: 3)
                                              //borderSide: BorderSide.none
                                              ),
                                          fillColor: Colors.grey[100],
                                          filled: true,
                                          labelText: DemoLocalizations.of(context)
                                              .verificationCode,
                                          hintText: DemoLocalizations.of(context).messageEnter,
                                          labelStyle: TextStyle(color: pwdColor),
                                          prefixIcon: Icon(
                                            Icons.message,
                                            color: pwdColor,
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, left: 15, right: 5),
                                    child: RaisedButton(
                                      padding: null,
                                      onPressed:
                                          nextTime == 0 ? getMessage : null,
                                      shape: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          borderSide: BorderSide.none),
                                      disabledColor: Colors.grey[200],
                                      child: Text(messageText),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    DemoLocalizations.of(context)
                                        .reminderMessage,
                                    textScaleFactor: 0.8,
                                    style: TextStyle(
                                      color: Colors.primaries[4][400],
                                    ),
                                  ))
                            ],
                          )
                        : TextFormField(
                            focusNode: focusNode2,
                            controller: _pwdController,
                            textInputAction: TextInputAction.done,
                            obscureText: obscureText,
                            maxLength: 16,
                            maxLengthEnforced: true,
                            style: TextStyle(color: pwdColor),
                            //设置输入光标样式
                            cursorRadius: Radius.circular(8),
                            cursorWidth: 4,
                            cursorColor: Rainbows[i],
                            onChanged: (value) {
                              //监听输入变化，改变光标颜
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
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              icon: Icon(
                                                Icons.remove_red_eye,
                                                color: pwdColor,
                                              ),
                                              onPressed: () {
                                                //如果直接清空会报错，因为需要先失去焦点再清空数
                                                //保证在组件build的第一帧时才去触发取消清空内容
                                                setState(() {
                                                  obscureText = !obscureText;
                                                });
                                              },
                                            ),
                                            IconButton(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              icon: Icon(
                                                Icons.delete,
                                                color: pwdColor,
                                              ),
                                              onPressed: () {
                                                //如果直接清空会报错，因为需要先失去焦点再清空数
                                                //保证在组件build的第一帧时才去触发取消清空内容
//                                                WidgetsBinding.instance
//                                                    .addPostFrameCallback((_) =>
//                                                        _pwdController.clear());
//                                              setState(() {
//                                                _pwdController.text="";
//                                              });
                                                _pwdController.clear();
                                                setState(() {});
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    : null,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Rainbows[6 - i], width: 3),
                                  borderRadius: BorderRadius.circular(55),
                                ),
                                //失去焦点时颜
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(55),
                                ),
                                //当validator报错时上面两种显示都会失效，所以必须设置默认显
                                //但是此时只有弧度生效，颜色和宽度并没有生
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(55),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).errorColor,
                                        width: 3)
                                    //borderSide: BorderSide.none
                                    ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(55),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).errorColor,
                                        width: 3)
                                    //borderSide: BorderSide.none
                                    ),
                                fillColor: Colors.grey[100],
                                filled: true,
                                labelText:
                                    DemoLocalizations.of(context).password,
                                hintText:
                                    DemoLocalizations.of(context).passwordEnter,
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
                              disabledColor: Colors.grey[300],
                              onPressed: logining
                                  ? null
                                  : () {
                                      //print("点击了按);
                                      isinput = false;
                                      if ((globalKey.currentState as FormState)
                                          .validate()) {
                                        setState(() {
                                          logining = true;
                                        });
                                        //验证通过提交数据
                                        isinput = true;
                                        var username = _unameController.text;

                                        if (!byPassword) {
                                          var password =
                                              _messageController.text;
                                          BmobMessage.verifySmsCode(
                                              context, username, password, () {
                                            MyDio.Login(
                                              Map.from({'number': username}),
                                              context: context,
                                              failed: () {
                                                logining = !logining;
                                                setState(() {});
                                              },
                                            );
                                          }, () {
                                            logining = !logining;
                                            setState(() {});
                                          });
                                        } else {
                                          var password = _pwdController.text;
                                          MyDio.Login(
                                              new Map<String, dynamic>.from({
                                                'number': username,
                                                'password': password
                                              }),
                                              context: context, failed: () {
                                            logining = !logining;
                                            setState(() {});
                                          });
                                        }
                                      } else {
                                        Future.delayed(Duration(seconds: 1),
                                            () {
                                          setState(() {
                                            isinput = true;
                                          });
                                        });
                                      }
                                    },
                              child: Text(logining
                                  ? DemoLocalizations.of(context).waiting
                                  : DemoLocalizations.of(context).login),
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: FlatButton(
                        child: Text(
                            DemoLocalizations.of(context).loginWay(byPassword)),
                        //透明
                        //按钮背景
                        color: Colors.transparent,
                        //点击时背景色
                        highlightColor: Colors.transparent,
                        //光斑
                        splashColor: Colors.transparent,
                        onPressed: () {
                          //切换输入框时需要让这两个切换的输入框释放焦点，否则各种错误
                          focusNode2.unfocus();
                          focusNode3.unfocus();
                          byPassword = !byPassword;
//                          if (byPassword) {
//                            loginWay =
//                                DemoLocalizations.of(context).loginByMessage;
//                          } else {
//                            loginWay =
//                                DemoLocalizations.of(context).loginByPassword;
//                          }

                          setState(() {});
                        },
                        textColor: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  DemoLocalizations.of(context).otherLoginWay,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Divider(
                  color: Colors.grey[400],
                ),
                QQInstalled
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: IconButton(
                          //点击时背景色
                          //                         highlightColor: Colors.transparent,
//                          //光斑
//                          splashColor: Colors.transparent,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(0),
                          icon: Image.asset(
                            MyImages.qq_login_white_24X24,
                          ),
                          onPressed: loginByQQ,
                        ))
                    : Text(
                        DemoLocalizations.of(context).nowNull,
                        style: TextStyle(color: Colors.grey),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
