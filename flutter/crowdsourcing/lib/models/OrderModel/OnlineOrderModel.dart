import 'dart:convert';


import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrder.dart';
import 'package:flutter/cupertino.dart';

class OnlineOrderModel extends ChangeNotifier {
  static const String onlineOrdersS = 'onlineOrders';
  List<OnlineOrder> _onlineOrders;

  List<OnlineOrder> get onlineOrders => _onlineOrders;

  int get length => onlineOrders?.length ?? 0;

  OnlineOrderModel() {
    var s = StorageManager.localStorage.getItem(onlineOrdersS);
    _onlineOrders = [];
    if (s != null) {
      for (var i in s) {
        onlineOrders.add(OnlineOrder.fromJsonMap(i));
      }
    }
  }

  saveOnlineOrders() {
    StorageManager.localStorage
        .setItem(onlineOrdersS,_onlineOrders);
  }

  /// 清除持久化的用户数据
  clearOnlineOrder() {
    _onlineOrders.clear();
  }

  addOnlineOrder(OnlineOrder onlineOrder) {
    _onlineOrders.add(onlineOrder);
    notifyListeners();
    saveOnlineOrders();
  }

  addOnlineOrders(List<OnlineOrder> onlineOrders) {
    clearOnlineOrder();
    _onlineOrders.addAll(onlineOrders);
    notifyListeners();
    saveOnlineOrders();
  }

  int notStartnumber(){
    int i = 0;
    for(var ii in _onlineOrders){
      if(ii.total==ii.remain){
        i++;
      }
    }
    return i;
  }


  int finishnumber(){
    int i = 0;
    for(var ii in _onlineOrders){
      if(ii.remain==0){
        i++;
      }
    }
    return i;
  }
  int doingnumber(){
    int i = 0;
    for(var ii in _onlineOrders){
      if(ii.remain>0&&ii.remain<ii.total){
        i++;
      }
    }
    return i;
  }

}
