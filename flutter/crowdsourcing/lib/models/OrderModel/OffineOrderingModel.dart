import 'dart:convert';

import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/models/object/order/Order.dart';
import 'package:crowdsourcing/models/object/order/offine/OffineOrdering.dart';
import 'package:flutter/cupertino.dart';

class OffineOrderingModel extends ChangeNotifier {
  static const String offineOrderingsS = 'offineOrderingings';
  List<OffineOrdering> _offineOrderings;

  List<OffineOrdering> get offineOrderings => _offineOrderings;

  int get length => offineOrderings?.length ?? 0;

  OffineOrderingModel() {
    var s = StorageManager.localStorage.getItem(offineOrderingsS);
    _offineOrderings = [];
    if (s != null) {
      for (var i in s) {
        offineOrderings.add(OffineOrdering.fromJsonMap(i));
      }
    }
  }

  saveOffineOrderings() {
    StorageManager.localStorage
        .setItem(offineOrderingsS,_offineOrderings);
  }

  /// 清除持久化的用户数据
  clearOffineOrdering() {
    _offineOrderings.clear();
  }

  addOffineOrdering(OffineOrdering offineOrdering) {
    _offineOrderings.add(offineOrdering);
    notifyListeners();
    saveOffineOrderings();
  }

  addOffineOrderings(List<OffineOrdering> offineOrderings) {
    clearOffineOrdering();
    _offineOrderings.addAll(offineOrderings);
    notifyListeners();
    saveOffineOrderings();
  }

  OffineOrdering getByOfferOrderId(int offerOrderId) {
    for (var i in offineOrderings) {
      if (i.offineOrderId == offerOrderId) {
        return i;
      }
    }
  }

  void finishOfferOrdering(int offerOrdering) {
    for (var i in offineOrderings) {
      if (i.offineOrderId == offerOrdering) {
        i.finishDate = DateTime.now();
        break;
      }
    }
  }

  bool hasTake(int peopleId) =>
      _offineOrderings.any((it) => it.peopleId == peopleId);


  int hasfinish(){
    int i = 0;
    for(var ii in _offineOrderings){
      if(ii.finishDate!=null){
        i++;
      }
    }
    return i;
  }

  int taking(){
    int i = 0;
    for(var ii in _offineOrderings){
      if(ii.finishDate==null){
        i++;
      }
    }
    return i;
  }
}
