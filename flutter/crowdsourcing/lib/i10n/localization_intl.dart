import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart'; //1

class DemoLocalizations {
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

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  String get title {
    return Intl.message(
      'Flutter APP',
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

  String get errorPhoneNumberLength {
    return Intl.message('Please enter your 11-digit mobile phone account',
        name: 'errorPhoneNumber');
  }

  String get errorPhoneNumberReg {
    return Intl.message('All input required are Numbers',
        name: 'errorPhoneNumberReg');
  }

  String get errorPwdLenth{
    return Intl.message("Password number must be greater than 8",name: 'errorPwdLenth');
  }

  String get errorPwdReg{
    return Intl.message("Passwords can only consist of Numbers and characters",name: 'errorPwdReg');
  }

  String get phoneNumber{
    return Intl.message("phoneNumber",name: 'phoneNumber');
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