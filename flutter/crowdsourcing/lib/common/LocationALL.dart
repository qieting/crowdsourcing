import 'dart:convert';
import 'package:flutter/services.dart';

class LocationAll {
  static var location;

  static Future<void> init() async {
    final response = await rootBundle.loadString('assets/locations.json');
    location = json.decode(response);
    location = location["province"];
  }

  static Future<List> getProvinces() async {
    if (location == null) {
      await init();
    }
    List<String> provinces = [];
    for (var province in location) {
      provinces.add(province["name"]);
    }
    return provinces;
  }

  static Future<List> getCities(String provinceName) async {
    if (location == null) {
      await init();
    }
    List<String> cities = [];
    for (var province in location) {
      if (((province["name"]) as String) == provinceName) {
        for (var city in province['city']) {
          cities.add(city["name"]);
        }
        break;
      }
    }
    return cities;
  }

  static Future<List> getPlots(String provinceName, String cityName) async {
    if (location == null) {
      await init();
    }
    List<String> plots = [];
    for (var province in location) {
      if (((province["name"]) as String) == provinceName) {
        for (var city in province['city']) {
          if (((city["name"]) as String) == cityName) {
            for (var plot in city['area']) {
              plots.add(plot);
            }
          }
        }
        break;
      }
    }
    return plots;
  }
}
