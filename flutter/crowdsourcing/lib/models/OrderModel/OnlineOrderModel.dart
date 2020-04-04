import 'dart:convert';


import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/models/object/order/Order.dart';
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
      if(ii.finish==ii.total){
        i++;
      }
    }
    return i;
  }
  int doingnumber(){
    int i = 0;
    for(var ii in _onlineOrders){
      if(ii.finish<ii.total&&ii.remain<ii.total){
        i++;
      }
    }
    return i;
  }


  int submit(){
    int i = 0;
    for(var ii in _onlineOrders){
      if(ii.submit>0){
        i+=ii.submit;
      }
    }
    return i;

  }

  List  getOrder(OrderStatus orderStatus){
    List<Order> myOrders =[];

    switch(orderStatus){
      case OrderStatus.take:
        for(var  i in _onlineOrders){
          if(i.finish<i.total&&i.remain<i.total){
            myOrders.add(i);
          }
        }

        // TODO: Handle this case.
        break;
      case OrderStatus.submit:
      // TODO: Handle this case.
        for(var  i in _onlineOrders){
          if(i.submit!=0){
            myOrders.add(i);
          }
        }
        break;
      case OrderStatus.finish:
      // TODO: Handle this case.
        for(var  i in _onlineOrders){
          if(i.finish==i.total){
            myOrders.add(i);
          }
        }
        break;
      case OrderStatus.no:
      // TODO: Handle this case.
        for(var  i in _onlineOrders){
          if(i.remain==i.total){
            myOrders.add(i);
          }
        }
        break;
      case OrderStatus.all:
      // TODO: Handle this case.
        myOrders.addAll(_onlineOrders);
        break;
      case OrderStatus.takeNoSubmit:
      // TODO: Handle this case.
        for(var  i in _onlineOrders){
          if(i.submit+i.finish+i.remain<i.total){
            myOrders.add(i);
          }
        }
        break;
    }
    return myOrders;
  }


}
