import 'dart:convert';

import 'package:crowdsourcing/models/object/order/Order.dart';
import 'package:crowdsourcing/models/object/order/offine/BuyMessage.dart';
import 'package:crowdsourcing/models/object/order/offine/location/Location.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineStep.dart';

class OnlineOrder extends Order {

  int number;
  List<OnlineStep> onlineSteps;

  static const String NUMBER = 'number';
  static const String ONLINESTEPS = "onlineSteps";

  OnlineOrder(
      {String title,
        this.number,
        this.onlineSteps,
        String describe,
        String require,
        String limitedTime,
        platFormLimit,
        buyMessages,
        int wancheng,
        int total,
        int remain ,
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
    this.total =total??number;
    this.remain=remain??number;
    this.id = id;
    this.peopleId = peopleId;
    this.finishTime=finishTime;
    this.createdTime=createdTime;
  }

  static OnlineOrder fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return OnlineOrder(
        title: map[Order.TITLE],
        total: map[Order.TOTAL] ,
        remain: map[Order.REMAIN]?? map[Order.TOTAL],
        describe: map[Order.DESCRIBE],
        require: map[Order.REQUIRE],
        limitedTime: map[Order.LIMITEDTIME],
        platFormLimit: map[Order.PLATFORMLIMIT],
        peopleId: map[Order.PEOPLEID],
        id: map[Order.ID],
        createdTime:map[Order.CREATEDTIME]!=null? DateTime.fromMicrosecondsSinceEpoch(map[Order.CREATEDTIME]):null,
        finishTime:map[Order.FINISHTIME]!=null? DateTime.fromMicrosecondsSinceEpoch(map[Order.FINISHTIME]):null,
        price: map[Order.Price],
      number: map[NUMBER],
      onlineSteps: (json.decode(map[ONLINESTEPS]) as List).map<OnlineStep>((f){ return OnlineStep.fromJsonMap(f);}).toList()
    );
  }

  Map<String,dynamic> toJson() {
    return {
      Order.TITLE: title,
      Order.DESCRIBE: describe,
      Order.REQUIRE: require,
      Order.LIMITEDTIME: limitedTime,
      Order.PLATFORMLIMIT: platFormLimit,
      Order.Price: price,
      Order.TOTAL:total,
      Order.REMAIN:remain,
      Order.ID: id,
      Order.PEOPLEID: peopleId,
      Order.CREATEDTIME:createdTime?.microsecondsSinceEpoch,
      Order.FINISHTIME:finishTime?.microsecondsSinceEpoch,
      NUMBER:number,
      ONLINESTEPS: json.encode(onlineSteps.map((f){ return f.toJson();}).toList())
    };
  }
}
