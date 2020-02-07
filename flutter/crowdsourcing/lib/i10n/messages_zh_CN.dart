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

  static m0(howMany) => "${Intl.plural(howMany, zero: 'There are no emails left', one: 'There is ${howMany} email left', other: 'There are ${howMany} emails left')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "errorPhoneNumberReg" : MessageLookupByLibrary.simpleMessage("输入必须为数字"),
    "errorPwdLenth" : MessageLookupByLibrary.simpleMessage("密码长度需大于等于8"),
    "errorPwdReg" : MessageLookupByLibrary.simpleMessage("密码只能包含字符和数字"),
    "guanggao" : MessageLookupByLibrary.simpleMessage("这是一个广告"),
    "login" : MessageLookupByLibrary.simpleMessage("登陆"),
    "password" : MessageLookupByLibrary.simpleMessage("密码"),
    "passwordEnter" : MessageLookupByLibrary.simpleMessage("输入你的密码"),
    "phoneNumber" : MessageLookupByLibrary.simpleMessage("账号"),
    "phoneNumberEnter" : MessageLookupByLibrary.simpleMessage("输入你的手机号"),
    "remainingEmailsMessage" : m0,
    "title" : MessageLookupByLibrary.simpleMessage("Flutter 应用")
  };
}
