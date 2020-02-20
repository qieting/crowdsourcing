// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
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
  String get localeName => 'messages';

  static m0(howMany) => "${Intl.plural(howMany, zero: 'verification code', other: 'after ${howMany} second')}";

  static m1(howMany) => "${Intl.plural(howMany, zero: 'There are no emails left', one: 'There is ${howMany} email left', other: 'There are ${howMany} emails left')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "err" : MessageLookupByLibrary.simpleMessage("erroe"),
    "errorPhoneNumberLength" : MessageLookupByLibrary.simpleMessage("Please enter your 11-digit mobile phone account"),
    "errorPhoneNumberReg" : MessageLookupByLibrary.simpleMessage("All input required are Numbers"),
    "errorPwdLenth" : MessageLookupByLibrary.simpleMessage("Password number must be greater than 8"),
    "errorPwdReg" : MessageLookupByLibrary.simpleMessage("Passwords can only consist of Numbers and characters"),
    "guanggao" : MessageLookupByLibrary.simpleMessage("this is a guanggao"),
    "login" : MessageLookupByLibrary.simpleMessage("Login"),
    "loginByMessage" : MessageLookupByLibrary.simpleMessage("verification code login"),
    "loginByPassword" : MessageLookupByLibrary.simpleMessage("password to login"),
    "loginCancel" : MessageLookupByLibrary.simpleMessage("Cancel the login"),
    "messagText" : m0,
    "messageEnter" : MessageLookupByLibrary.simpleMessage("enter the verification code"),
    "messageErr" : MessageLookupByLibrary.simpleMessage("Verification code error"),
    "networkAnomaly" : MessageLookupByLibrary.simpleMessage("network anomaly"),
    "nowNull" : MessageLookupByLibrary.simpleMessage("not available"),
    "otherLoginWay" : MessageLookupByLibrary.simpleMessage("other ways"),
    "password" : MessageLookupByLibrary.simpleMessage("password"),
    "passwordEnter" : MessageLookupByLibrary.simpleMessage("enter your password"),
    "phoneNumber" : MessageLookupByLibrary.simpleMessage("phoneNumber"),
    "phoneNumberEnter" : MessageLookupByLibrary.simpleMessage("enter your phone Number"),
    "remainingEmailsMessage" : m1,
    "reminderMessage" : MessageLookupByLibrary.simpleMessage("Unregistered phones are automatically registered after verification"),
    "status401" : MessageLookupByLibrary.simpleMessage("Invalid login status"),
    "status407" : MessageLookupByLibrary.simpleMessage("Remote login detected, please login again"),
    "status500" : MessageLookupByLibrary.simpleMessage("Server emitter tube exception error"),
    "statusOhters" : MessageLookupByLibrary.simpleMessage("Network connection abnormal, error code"),
    "title" : MessageLookupByLibrary.simpleMessage("Flutter APP"),
    "userInfoError" : MessageLookupByLibrary.simpleMessage("obtain personal information error"),
    "userInfoFailed" : MessageLookupByLibrary.simpleMessage("Failed to obtain personal information"),
    "verificationCode" : MessageLookupByLibrary.simpleMessage("Verification code"),
    "waiting" : MessageLookupByLibrary.simpleMessage("waiting . . .")
  };
}
