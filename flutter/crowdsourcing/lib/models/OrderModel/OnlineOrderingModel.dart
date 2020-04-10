import 'dart:convert';

import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrdering.dart';
import 'package:flutter/cupertino.dart';

class OnlineOrderingModel extends ChangeNotifier {
  static const String onlineOrderingsS = 'onlineOrderingings';
  List<OnlineOrdering> _onlineOrderings;

  List<OnlineOrdering> get onlineOrderings => _onlineOrderings;

  int get length => onlineOrderings?.length ?? 0;

  OnlineOrderingModel() {
    var s = StorageManager.localStorage.getItem(onlineOrderingsS);
    _onlineOrderings = [];
    if (s != null) {
      for (var i in s) {
        onlineOrderings.add(OnlineOrdering.fromJsonMap(i));
      }
    }
  }

  saveOnlineOrderings() {
    StorageManager.localStorage.setItem(
        onlineOrderingsS,
        _onlineOrderings);
  }

  /// 清除持久化的用户数据
  clearOnlineOrdering() {
    _onlineOrderings.clear();
  }

  addOnlineOrdering(OnlineOrdering onlineOrdering) {
    _onlineOrderings.add(onlineOrdering);
    notifyListeners();
    saveOnlineOrderings();
  }

  addOnlineOrderings(List<OnlineOrdering> onlineOrderings) {
    clearOnlineOrdering();
    _onlineOrderings.addAll(onlineOrderings);
    notifyListeners();
    saveOnlineOrderings();
  }

  OnlineOrdering getByOnlineOrderId(int offerOrderId) {
    for (var i in onlineOrderings) {
      if (i.onlineOrderId == offerOrderId) {
        return i;
      }
    }
  }

  void finishOfferOrdering(int offerOrdering) {
    for (var i in onlineOrderings) {
      if (i.onlineOrderId == offerOrdering) {
        i.finishDate = DateTime.now();
        break;
      }
    }
  }

  bool hasTake(int peopleId) =>
      _onlineOrderings.any((it) => it.peopleId == peopleId);

  int hasfinish() {
    int i = 0;
    for (var ii in _onlineOrderings) {
      if (ii.finishDate != null) {
        i++;
      }
    }
    return i;
  }

  int taking() {
    int i = 0;
    for (var ii in _onlineOrderings) {
      if (ii.finishDate == null) {
        i++;
      }
    }
    return i;
  }

  void refresh(OnlineOrdering onlineOrdering) {
    for (var ii in _onlineOrderings) {
      if (ii.id == onlineOrdering.id) {
        onlineOrderings.remove(ii);
        onlineOrderings.add(onlineOrdering);
        break;
      }
    }
    notifyListeners();
    saveOnlineOrderings();
  }


  findByOrderId(int id){
    for(var i in _onlineOrderings){
      if(i.onlineOrderId==id){
        return i;
      }
    }
  }
}
