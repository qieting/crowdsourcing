// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  static m0(howMany) => "${Intl.plural(howMany, zero: '接单', one: '发现', two: '消息', other: '我')}";

  static m1(howMany) => "${Intl.plural(howMany, zero: '获取验证码', other: '${howMany}秒后获得')}";

  static m2(howMany) => "${Intl.plural(howMany, zero: 'There are no emails left', one: 'There is ${howMany} email left', other: 'There are ${howMany} emails left')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "err" : MessageLookupByLibrary.simpleMessage("异常"),
    "errorPhoneNumberLength" : MessageLookupByLibrary.simpleMessage("请输入您的手机号"),
    "errorPhoneNumberReg" : MessageLookupByLibrary.simpleMessage("输入必须为数字"),
    "errorPwdLenth" : MessageLookupByLibrary.simpleMessage("密码长度需大于等于8"),
    "errorPwdReg" : MessageLookupByLibrary.simpleMessage("密码只能包含字符和数字"),
    "guanggao" : MessageLookupByLibrary.simpleMessage("这是一个广告"),
    "login" : MessageLookupByLibrary.simpleMessage("登陆"),
    "loginByMessage" : MessageLookupByLibrary.simpleMessage("验证码登录"),
    "loginByPassword" : MessageLookupByLibrary.simpleMessage("密码登录"),
    "loginCancel" : MessageLookupByLibrary.simpleMessage("取消登录"),
    "mainTitle" : m0,
    "messagText" : m1,
    "messageEnter" : MessageLookupByLibrary.simpleMessage("请输入验证码"),
    "messageErr" : MessageLookupByLibrary.simpleMessage("验证码错误"),
    "networkAnomaly" : MessageLookupByLibrary.simpleMessage("网络异常"),
    "nowNull" : MessageLookupByLibrary.simpleMessage("暂无"),
    "otherLoginWay" : MessageLookupByLibrary.simpleMessage("其他方式"),
    "password" : MessageLookupByLibrary.simpleMessage("密码"),
    "passwordEnter" : MessageLookupByLibrary.simpleMessage("输入你的密码"),
    "phoneNumber" : MessageLookupByLibrary.simpleMessage("账号"),
    "phoneNumberEnter" : MessageLookupByLibrary.simpleMessage("输入你的手机号"),
    "remainingEmailsMessage" : m2,
    "reminderMessage" : MessageLookupByLibrary.simpleMessage("未注册的手机验证后自动注册"),
    "status401" : MessageLookupByLibrary.simpleMessage("登陆状态无效，请登录"),
    "status407" : MessageLookupByLibrary.simpleMessage("检测到异地登陆,请重新登陆"),
    "status500" : MessageLookupByLibrary.simpleMessage("服务器发射管异常错误"),
    "statusOhters" : MessageLookupByLibrary.simpleMessage("网络连接异常，错误码"),
    "title" : MessageLookupByLibrary.simpleMessage("Flutter 应用"),
    "userInfoError" : MessageLookupByLibrary.simpleMessage("获取用户信息异常"),
    "userInfoFailed" : MessageLookupByLibrary.simpleMessage("获取用户信息失败"),
    "verificationCode" : MessageLookupByLibrary.simpleMessage("验证码"),
    "waiting" : MessageLookupByLibrary.simpleMessage("登陆中. . .")
  };
}
