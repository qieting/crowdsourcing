




class User {

  String phone, qq, weixin;
  double money;

  static const String PHONE = 'number';
  static const String QQ = 'qq';
  static const String WEIXIN = 'weixin';
  static const String MONEY = 'money';

  static User fromJsonMap(Map<String, dynamic> map) {
    if (map == null ) return null;
    User user = User();
    user.phone = map[PHONE];
    user.qq = map[QQ];
    user.weixin = map[WEIXIN];
    user.money = map[MONEY];
    return user;
  }

  Map toJson() => {PHONE: phone, WEIXIN: weixin, QQ: qq, MONEY: money};



}
