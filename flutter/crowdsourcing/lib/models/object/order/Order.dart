
class Order{
  static const String TITLE = "title";
  static const String DESCRIBE = 'describe';
  static const String REQUIRE = 'require';
  static const String LIMITEDTIME = 'limitedTime';
  static const String PLATFORMLIMIT = 'platformLimit';
  static const String Price = 'price';
  static const String ID = "id";
  static const String PEOPLEID = 'peopleId';
  static const String WANCHENG ='wancheng';
  static const String CREATEDTIME = 'createdTime';
  static const String FINISHTIME = 'finishTime';



  String title;
  double price;
  String describe, require, limitedTime;
  int platFormLimit, id, peopleId;
  int wancheng;
  DateTime createdTime,finishTime;
}