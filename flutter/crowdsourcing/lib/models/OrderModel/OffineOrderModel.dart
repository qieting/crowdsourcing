import 'dart:convert';


import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/models/object/order/offine/OffineOrder.dart';
import 'package:flutter/cupertino.dart';

class OffineOrderModel extends ChangeNotifier {
  static const String offineOrdersS = 'offineOrders';
  List<OffineOrder> _offineOrders;

  List<OffineOrder> get offineOrders => _offineOrders;

  int get length => offineOrders?.length ?? 0;

  OffineOrderModel() {
    var s = StorageManager.localStorage.getItem(offineOrdersS);
    _offineOrders = [];
    if (s != null) {
      for (var i in s) {
        offineOrders.add(OffineOrder.fromJsonMap(i));
      }
    }
  }

  saveOffineOrders() {
    StorageManager.localStorage
        .setItem(offineOrdersS,_offineOrders);
  }

  /// 清除持久化的用户数据
  clearOffineOrder() {
    _offineOrders.clear();
  }

  addOffineOrder(OffineOrder offineOrder) {
    _offineOrders.add(offineOrder);
    notifyListeners();
    saveOffineOrders();
  }

  addOffineOrders(List<OffineOrder> offineOrders) {
    clearOffineOrder();
    _offineOrders.addAll(offineOrders);
    notifyListeners();
    saveOffineOrders();
  }

  int notStartnumber(){
    int i = 0;
    for(var ii in _offineOrders){
      if(ii.total==ii.remain){
        i++;
      }
    }
    return i;
  }


  int finishnumber(){
    int i = 0;
    for(var ii in _offineOrders){
      if(ii.remain==0){
        i++;
      }
    }
    return i;
  }
  int doingnumber(){
    int i = 0;
    for(var ii in _offineOrders){
      if(ii.remain>0&&ii.remain<ii.total){
        i++;
      }
    }
    return i;
  }


}
