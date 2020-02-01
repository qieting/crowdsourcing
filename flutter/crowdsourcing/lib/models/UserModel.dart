import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:flutter/cupertino.dart';

import 'object/user.dart';

class UserModel extends ChangeNotifier {

  static const String userS ='user';
  User _user;

  User get user => _user;

  bool get hasUser => user != null;

  UserModel() {
  }

  saveUser(User user) {
    _user = user;
    notifyListeners();
    StorageManager.localStorage.setItem(userS, user);
  }

  /// 清除持久化的用户数据
  clearUser() {
    _user = null;
    notifyListeners();
    StorageManager.localStorage.deleteItem(userS);
  }
}
