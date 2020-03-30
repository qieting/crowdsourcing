class Order {
  static const String TITLE = "title";
  static const String DESCRIBE = 'describe';
  static const String REQUIRE = 'require';
  static const String LIMITEDTIME = 'limitedTime';
  static const String PLATFORMLIMIT = 'platFormLimit';
  static const String Price = 'price';
  static const String ID = "id";
  static const String PEOPLEID = 'peopleId';
  static const String CREATEDTIME = 'createdTime';
  static const String FINISHTIME = 'finishTime';
  static const String TOTAL = 'total';
  static const String REMAIN = 'remain';

  String title;
  double price;
  String describe, require, limitedTime;
  int platFormLimit, id, peopleId;
  int total, remain;
  DateTime createdTime, finishTime;
}
