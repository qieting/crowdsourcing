import 'dart:convert';

import 'package:crowdsourcing/models/object/order/offine/BuyMessage.dart';
import 'package:crowdsourcing/models/object/order/Order.dart';
import 'package:crowdsourcing/models/object/order/offine/location/Location.dart';

class OffineOrder extends Order {
  List<BuyMessage> buyMessages;
  Location end;

  //double price;

  static const String BUYMESSAGES = 'buyMessages';
  static const String END = "end";

  OffineOrder(
      {String title,
      String describe,
      String require,
      String limitedTime,
      platFormLimit,
      buyMessages,
      int wancheng,
      double price,
      int id,
      int peopleId,
      Location end,
        DateTime createdTime,
        DateTime finishTime,
      }) {
    this.title = title;
    this.price = price;
    this.describe = describe;
    this.limitedTime = limitedTime;
    this.require = require;
    this.platFormLimit = platFormLimit;
    this.wancheng = wancheng;
    this.id = id;
    this.peopleId = peopleId;
    this.finishTime=finishTime;
    this.createdTime=createdTime;
  }

  static OffineOrder fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return OffineOrder(
        title: map[Order.TITLE],
        wancheng: map[Order.WANCHENG] ?? 0,
        describe: map[Order.DESCRIBE],
        require: map[Order.REQUIRE],
        limitedTime: map[Order.LIMITEDTIME],
        platFormLimit: map[Order.PLATFORMLIMIT],
        end: Location(id: map[END]),
        buyMessages: ((json.decode(map[BUYMESSAGES])) as List).map<BuyMessage>((it) {
          return BuyMessage.fromJsonMap(it);
        }).toList(),
        peopleId: map[Order.PEOPLEID],
        id: map[Order.ID],
        createdTime:map[Order.CREATEDTIME]!=null? DateTime.fromMicrosecondsSinceEpoch(map[Order.CREATEDTIME]):null,
        finishTime:map[Order.FINISHTIME]!=null? DateTime.fromMicrosecondsSinceEpoch(map[Order.FINISHTIME]):null,
        price: map[Order.Price]);
  }

  Map toJson() {
    return {
      Order.TITLE: title,
      Order.DESCRIBE: describe,
      Order.REQUIRE: require,
      Order.LIMITEDTIME: limitedTime,
      Order.PLATFORMLIMIT: platFormLimit,
      END: end?.id ?? '-1',
      Order.Price: price,
      Order.WANCHENG: wancheng,
      Order.ID: id,
      Order.PEOPLEID: peopleId,
      Order.CREATEDTIME:createdTime.microsecondsSinceEpoch,
      Order.FINISHTIME:finishTime.microsecondsSinceEpoch,
      BUYMESSAGES: json.encode(buyMessages.map((it) {
        return it.toJson();
      }).toList())
    };
  }
}
