

//存储相应的url
class MyUrl {


  //服务器根url
  static const String baseUrl = "http://192.168.2.103:8080/";

  //获取订单内相关的各种图片，忽略token
  //第一个带有根路径，用于图片的直接加载，第二个是dio使用
  static const String imageUrl = baseUrl+"images/";
  static const String images = 'images/';
  static const String imageUp = 'imageUp/';

  //登陆注册等
  static const String people = "people";

  //线下订单位置
  static const String location = "location";

  //离线订单等
  static const String offineOrder = "offineOrder";

  //离线订单接单消息等
  static const String offineOrdering = "offineOrdering";

  //在线订单等
  static const String onlineOrder = "onlineOrder";

  //总订单
  static const String order = 'order';

  //在线订单接单消息等
  static const String onlineOrdering = "onlineOrdering";

  //结束订单，设置该接口是因为，onlineOrdering的put接口已经被订单使用了
  static const String finishonlineOrdering='finishonlineOrdering';

  //获取不同种类的订单，主要根据个人
  static const String takeOrder='takeOrder';



}
