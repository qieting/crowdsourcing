import 'package:crowdsourcing/net/MyUrl.dart';

class User {
  String phone, qq, weixin, head, nick, gender;
  double money;
  List locations;
  int id;

  static const String PHONE = 'number';
  static const String QQ = 'qq';
  static const String WEIXIN = 'weixin';
  static const String MONEY = 'money';
  static const String HEAD = "head";
  static const String NICK = "nick";
  static const String GENDER = "gender";
  static const String Id = 'id';

  String get mYHead {
    if (head == null || head.startsWith("http")) {
      return head;
    } else
      return MyUrl.baseUrl + head;
  }

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
    user.id = map[Id];
    user.nick = map[NICK] ?? "id" + user.id.toString();
    return user;
  }

  Map toJson() => {
        PHONE: phone,
        WEIXIN: weixin,
        QQ: qq,
        MONEY: money,
        HEAD: head,
        NICK: nick,
        GENDER: gender,
        Id: id
      };
}
