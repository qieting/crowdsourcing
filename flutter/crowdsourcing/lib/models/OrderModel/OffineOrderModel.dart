import 'dart:convert';


import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/models/object/order/Order.dart';
import 'package:crowdsourcing/models/object/order/offine/OffineOrder.dart';
import 'package:crowdsourcing/pages/MyOrderPage.dart';
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
      if(ii.finish==ii.total){
        i++;
      }
    }
    return i;
  }
  int doingnumber(){
    int i = 0;
    for(var ii in _offineOrders){
      if(ii.finish<ii.total&&ii.remain<ii.total){
        i++;
      }
    }
    return i;
  }

  int submit(){
    int i = 0;
    for(var ii in _offineOrders){
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
        for(var  i in _offineOrders){
          if(i.finish<i.total&&i.remain<i.total){
            myOrders.add(i);
          }
        }

        // TODO: Handle this case.
        break;
      case OrderStatus.submit:
        // TODO: Handle this case.
        for(var  i in _offineOrders){
          if(i.submit!=0){
            myOrders.add(i);
          }
        }
        break;
      case OrderStatus.finish:
        // TODO: Handle this case.
        for(var  i in _offineOrders){
          if(i.finish==i.total){
            myOrders.add(i);
          }
        }
        break;
      case OrderStatus.no:
        // TODO: Handle this case.
        for(var  i in _offineOrders){
          if(i.remain==i.total){
            myOrders.add(i);
          }
        }
        break;
      case OrderStatus.all:
        // TODO: Handle this case.
      myOrders.addAll(_offineOrders);
        break;
      case OrderStatus.takeNoSubmit:
        // TODO: Handle this case.
        for(var  i in _offineOrders){
          if(i.submit+i.finish+i.remain<i.total){
            myOrders.add(i);
          }
        }
        break;
    }
    return myOrders;
  }

}
