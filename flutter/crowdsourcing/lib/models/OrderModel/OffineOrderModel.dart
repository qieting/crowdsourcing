import 'dart:convert';

import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/models/object/OffineOrdering.dart';
import 'package:crowdsourcing/models/object/Order.dart';
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

//  changeOffineOrdering(int i, OffineOrdering ffineOrder) {
//    _offineOrderings[i] = offineOrdering;
//    notifyListeners();
//    saveOffineOrderings();
//  }
//
//
//  deleteOffineOrde(int id) {
//    for (OffineOrdeoffineOrdering in _offineOrderings) {
//      if (offineOrdering.id == id) {
//        _offineOrderings.remove(offineOrdering);
//        break;
//      }
//    }
//    MyDio.deleteOffineOrde(id);
//
//    saveOffineOrdes();
//  }
}
