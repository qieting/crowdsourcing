

class User {
  String phone, qq, weixin;
  double money;

  static final String PHONE = 'phone';
  static final String QQ = 'qq';
  static final String WEIXIN = 'weixin';
  static final String MONEY = 'money';

  static User fromJsonMap(Map<String, dynamic> map) {
    if (map == null || map[PHONE] == null) return null;
    User user = User();
    user.phone = map[PHONE];
    user.qq = map[QQ];
    user.weixin = map[WEIXIN];
    user.money = map[MONEY];
    return user;
  }

  Map toJson() => {PHONE: phone, WEIXIN: weixin, QQ: qq, MONEY: money};



}
