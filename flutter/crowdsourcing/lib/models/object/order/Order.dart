enum OrderStatus {
  //已经领取任务,但是未完成
  take,
  //等待审核
  submit,
  //已完成
  finish,
  //未领取
  no,
  //所有
  all,
  //已经领取但是未完成
  takeNoSubmit,
}


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
  static const String SUBMIT = 'submit';
  static const String FINISH = 'finish';


  String title;
  double price;
  String describe, require, limitedTime;
  int platFormLimit, id, peopleId,finish;
  //总数，剩余的未接数，提交等待审核数目,已经完成数目
  int total, remain,submit;
  DateTime createdTime, finishTime;


  int get take{
    return total-finish-remain;
  }
}
