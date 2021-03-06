import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart'; //1

class DemoLocalizations {
  static DemoLocalizations demoLocalizations;

  static Future<DemoLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    //2
    print(localeName);
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new DemoLocalizations();
    });
  }

  static init(BuildContext context) {
    demoLocalizations = DemoLocalizations.of(context);
  }

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  String get title {
    return Intl.message(
      'crowdsourcing',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }

  String get guanggao {
    return Intl.message(
      'this is a guanggao',
      name: 'guanggao',
    );
  }

  String get password {
    return Intl.message(
      'password',
      name: 'password',
    );
  }

  String get login {
    return Intl.message('Login', name: 'login');
  }

  String get errorPhoneNumberReg {
    return Intl.message('All input required are Numbers',
        name: 'errorPhoneNumberReg');
  }

  String get errorPwdLenth {
    return Intl.message("Password number must be greater than 8",
        name: 'errorPwdLenth');
  }

  String get errorPwdReg {
    return Intl.message("Passwords can only consist of Numbers and characters",
        name: 'errorPwdReg');
  }

  String get phoneNumber {
    return Intl.message("phoneNumber", name: 'phoneNumber');
  }

  String get phoneNumberEnter {
    return Intl.message("enter your phone Number", name: 'phoneNumberEnter');
  }

  String get passwordEnter {
    return Intl.message("enter your password", name: 'passwordEnter');
  }

  remainingEmailsMessage(int howMany) => Intl.plural(howMany,
      zero: 'There are no emails left',
      one: 'There is $howMany email left',
      other: 'There are $howMany emails left',
      name: "remainingEmailsMessage",
      args: [howMany],
      desc: "How many emails remain after archiving.",
      examples: const {'howMany': 42, 'userName': 'Fred'});

  String get otherLoginWay {
    return Intl.message("other ways", name: 'otherLoginWay');
  }

  String get nowNull {
    return Intl.message("not available", name: 'nowNull');
  }

  String get loginByMessage {
    return Intl.message("verification code login", name: 'loginByMessage');
  }

  String get loginByPassword {
    return Intl.message("password to login", name: 'loginByPassword');
  }

  loginWay(bool password) {
    if (password) {
      return loginByMessage;
    } else {
      return loginByPassword;
    }
  }

  String get waiting {
    return Intl.message("waiting . . .", name: 'waiting');
  }

  messagText(int howMany) => Intl.plural(howMany,
      zero: 'verification code',
      other: 'after $howMany second',
      name: "messagText",
      args: [howMany]);

  String get verificationCode {
    return Intl.message("Verification code", name: 'verificationCode');
  }

  String get messageEnter {
    return Intl.message("enter the verification code", name: 'messageEnter');
  }

  String get errorPhoneNumberLength {
    return Intl.message('Please enter your 11-digit mobile phone account',
        name: 'errorPhoneNumberLength');
  }

  String get reminderMessage {
    return Intl.message(
        'Unregistered phones are automatically registered after verification',
        name: 'reminderMessage');
  }

  String get messageErr {
    return Intl.message('Verification code error', name: 'messageErr');
  }

  String get status401 {
    return Intl.message('Invalid login status', name: 'status401');
  }

  String get status407 {
    return Intl.message('Remote login detected, please login again',
        name: 'status407');
  }

  String get status500 {
    return Intl.message('Server emitter tube exception error',
        name: 'status500');
  }

  String get statusOhters {
    return Intl.message('Network connection abnormal, error code',
        name: 'statusOhters');
  }

  String get networkAnomaly {
    return Intl.message('network anomaly', name: 'networkAnomaly');
  }

  String get loginCancel {
    return Intl.message('Cancel the login', name: 'loginCancel');
  }

  String get err {
    return Intl.message('erroe', name: 'err');
  }

  String get userInfoFailed {
    return Intl.message('Failed to obtain personal information',
        name: 'userInfoFailed');
  }

  String get userInfoError {
    return Intl.message('obtain personal information error',
        name: 'userInfoError');
  }

  mainTitle(int howMany) => Intl.plural(howMany,
      zero: 'order',
      one: "find",
      two: 'message',
      other: 'i',
      name: "mainTitle",
      args: [howMany]);

  //网络状态相关提示词
  //连接超时
  String get connectionTimeout {
    return Intl.message("connection timeout", name: "connectionTimeout");
  }

  //接收超时
  String get receiveTimeout {
    return Intl.message("receive timeout", name: "receiveTimeout");
  }

  //发送超时
  String get sendTimeout {
    return Intl.message("send timeout", name: "sendTimeout");
  }

  //拒绝访问
  String get accessDenied {
    return Intl.message("access denied", name: "accessDenied");
  }

  //bug
  String get bug {
    return Intl.message("There is a bug", name: "bug");
  }

  //chooseImage用到的词语，选择图片相关
  String get photoChoose {
    return Intl.message("Please select picture", name: "photoChoose");
  }

  //相册
  String get album {
    return Intl.message("album", name: "album");
  }

  //拍照
  String get photograph {
    return Intl.message("photograph", name: "photograph");
  }

  //任务相关
  //线上任务选择
  String get online {
    return Intl.message("online", name: "online");
  }

  //线下任务选择
  String get offline {
    return Intl.message("offline", name: "offline");
  }

  //发布悬赏
  String get reaseTask {
    return Intl.message("release a task", name: "reaseTask");
  }

  //信息提示相关
  //昵称为空
  String get nicknull {
    return Intl.message("nick is null", name: "nicknull");
  }

  //手机号为空
  String get phonenull {
    return Intl.message("phone is null", name: "phonenull");
  }

  //定位相关
  //定位无权限
  String get locationNoPermisson {
    return Intl.message("No location permission, please grant permission",
        name: "locationPermisson");
  }

  //定位无信息
  String get locationNoMessage {
    return Intl.message("You have not turned on the positioning function, please turn on the positioning",
        name: "locationNoMessage");
  }

  //加载中，请等待
  String get loading {
    return Intl.message("loading,please wait",
        name: "loading");
  }
  //钱包
  String get wallet {
    return Intl.message("wallet",
        name: "wallet");
  }
  //充值
  String get recharge {
    return Intl.message("recharge",
        name: "recharge");
  }
  //提现
  String get withdraw {
    return Intl.message("withdraw",
        name: "withdraw");
  }
}

//Locale代理类
class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<DemoLocalizations> load(Locale locale) {
    //3
    return DemoLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
