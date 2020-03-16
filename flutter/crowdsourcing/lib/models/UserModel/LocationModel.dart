import 'dart:convert';

import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/models/object/Location.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:flutter/cupertino.dart';

class LocationModel extends ChangeNotifier {
  static const String locationS = 'location';
  List<Location> _locations;

  List get locations => _locations;

  Location getLocation(int i) {
    return _locations[i];
  }

  int get size => locations.length;

  bool get isEmpty => size == 0;

  LocationModel() {
    var s = StorageManager.localStorage.getItem(locationS);
    _locations = [];
    if (s != null) {
      var a = json.decode(s);
      for (var i in a) {
        _locations.add(Location.fromJsonMap(i));
      }
    }
  }

  saveLocations() {
    StorageManager.localStorage.setItem(locationS, json.encode(_locations));
  }

  /// 清除持久化的用户数据
  clearLocation() {
    _locations.clear();
  }

  addLocation(Location location) {
    if(location.isMain){
      for (Location location in _locations) {
        if (location.isMain) {
          location.isMain= false;
          break;
        }
      }
    }
    _locations.add(location);
    notifyListeners();
    saveLocations();
  }

  addLocations(List<Location> locations) {
    clearLocation();
    _locations.addAll(locations);
    notifyListeners();
    saveLocations();
  }

  changeLocation(int i, Location location) {
    _locations[i] = location;
    notifyListeners();
    saveLocations();
  }

  Location getMainLocation() {
    for (Location location in _locations) {
      if (location.isMain) {
        return location;
      }
    }
    return isEmpty ? null : _locations[0];
  }

  changeMainLocation(Location l) {
    for (Location location in _locations) {
      if (location.isMain) {
        location.isMain = false;
        if (location.id == l.id) {
          MyDio.changeLocation(l);
          saveLocations();
          return;
        }
        break;
      }
    }
    l.isMain = true;
    MyDio.changeLocation(l);
    saveLocations();
  }

  deleteLocation(int id) {
    for (Location location in _locations) {
      if (location.id == id) {
        _locations.remove(location);
        break;
      }
    }
    MyDio.deleteLocation(id);

    saveLocations();
  }
}
