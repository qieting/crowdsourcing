import 'dart:convert';

import 'package:crowdsourcing/models/object/BuyMessage.dart';
import 'package:crowdsourcing/models/object/Location.dart';
import 'package:crowdsourcing/models/object/Order.dart';
import 'package:intl/intl.dart';

class OffineOrder extends Order {
  String describe, require, limitedTime;
  int platFormLimit, id, peopleId;
  List<BuyMessage> buyMessages;
  Location end;
  int wancheng;

  //double price;

  static const String TITLE = "title";
  static const String DESCRIBE = 'describe';
  static const String REQUIRE = 'require';
  static const String LIMITEDTIME = 'limitedTime';
  static const String PLATFORMLIMIT = 'platformLimit';
  static const String BUYMESSAGES = 'buyMessages';
  static const String END = "end";
  static const String Price = 'price';
  static const String ID = "id";
  static const String PEOPLEID = 'peopleId';
  static const String WANCHENG ='wancheng';

  OffineOrder(
      {String title,
      this.describe,
      this.require,
      this.limitedTime,
      this.platFormLimit,
      this.buyMessages,
        this.wancheng,
      double price,
      this.id,
      this.peopleId,
      this.end}) {
    this.title = title;
    this.price = price;
  }

  static OffineOrder fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;
    String buymessage = map[BUYMESSAGES];
    //buymessage = buymessage.substring(1, buymessage.length - 1);
    return OffineOrder(
        title: map[TITLE],
        wancheng: map[WANCHENG]??0,
        describe: map[DESCRIBE],
        require: map[REQUIRE],
        limitedTime: map[LIMITEDTIME],
        platFormLimit: map[PLATFORMLIMIT],
        end: Location(id: map[END]),
        buyMessages: ((json.decode(buymessage)) as List).map<BuyMessage>((it) {
          return BuyMessage.fromJsonMap(it);
        }).toList(),
        peopleId: map[PEOPLEID],
        id: map[ID],
        price: map[Price]);
  }

  Map toJson() {
    String bubbbb = '';
//    buyMessages.map((it) {
//      print(it.toJson().toString());
//      bubbbb=bubbbb+it.toJson().toString();
//    });
    return {
      TITLE: title,
      DESCRIBE: describe,
      REQUIRE: require,
      LIMITEDTIME: limitedTime,
      PLATFORMLIMIT: platFormLimit,
      END: end?.id ?? '-1',
      Price: price,
      WANCHENG:wancheng,
      ID: id,
      PEOPLEID: peopleId,
      BUYMESSAGES: json.encode(buyMessages.map((it) {
        return it.toJson();
      }).toList())
    };
  }
}
