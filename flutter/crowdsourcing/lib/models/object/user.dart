class User {
  String phone, qq, weixin, head, nick, gender;
  double money;

  static const String PHONE = 'number';
  static const String QQ = 'qq';
  static const String WEIXIN = 'weixin';
  static const String MONEY = 'money';
  static const String HEAD = "head";
  static const String NICK = "nick";
  static const String GENDER = "gender";

  static User fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;
    User user = User();
    user.phone = map[PHONE];
    user.qq = map[QQ];
    user.weixin = map[WEIXIN];
    user.money = map[MONEY];
    user.nick = map[NICK];
    user.head = map[HEAD];
    user.gender = map[GENDER];
    return user;
  }

  Map toJson() => {
        PHONE: phone,
        WEIXIN: weixin,
        QQ: qq,
        MONEY: money,
        HEAD: head,
        NICK: nick,
        GENDER: gender
      };
}
