import 'package:flutter/cupertino.dart';

//自定义的可被监听的list
class ListNotify<T> extends ChangeNotifier {
  var _list = new List<T>();

  int get length => _list.length;

  add(T t) {
    _list.add(t);
    notifyListeners();
  }

  removeAt(int i) {
    _list.removeAt(i);
    notifyListeners();
  }

  remove(T t) {
    _list.remove(t);
    notifyListeners();
  }

  T get(int i) => _list[i];

  T operator [](i) => get(i);
}
