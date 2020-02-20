import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:data_plugin/bmob/bmob_sms.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_handled.dart';
import 'package:data_plugin/bmob/response/bmob_sent.dart';
import 'package:flutter/material.dart';

class BmobMessage {
  ///发送短信验证码：需要手机号码
  static sendSms(BuildContext context, String _phoneNumber, Function success) {
    BmobSms bmobSms = BmobSms();
    bmobSms.template = "注册";
    bmobSms.mobilePhoneNumber = _phoneNumber;
    bmobSms.sendSms().then((BmobSent bmobSent) {
      MyToast.toast("发送成功：" + bmobSent.smsId.toString());
      success();
    }).catchError((e) {
      MyToast.toast("发送异常：" + BmobError.convert(e).code.toString());
    });
  }

  ///验证短信验证码：需要手机号码和验证码
  static verifySmsCode(BuildContext context, String _phoneNumber,
      String _smsCode, success, failed) {
    BmobSms bmobSms = BmobSms();
    bmobSms.mobilePhoneNumber = _phoneNumber;
    bmobSms.verifySmsCode(_smsCode).then((BmobHandled bmobHandled) {
      MyToast.toast("验证成功：" + bmobHandled.msg);
      success();
    }).catchError((e) {
      failed();
      MyToast.toast("验证异常：" + BmobError.convert(e).error);
    });
  }
}
