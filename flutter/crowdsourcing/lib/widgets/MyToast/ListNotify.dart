import 'package:flutter/cupertino.dart';

class ListNotify<T> extends ChangeNotifier {
  var _list = new List<T>();

  int get length => _list.length;

  add(T t , {int second :0 ,int millisecond =0})  {
    _list.add(t);
//    Future.delayed(new Duration(seconds: second, milliseconds:  millisecond),(){
//      remove(t);
//      print("减少");
//    });
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
}
