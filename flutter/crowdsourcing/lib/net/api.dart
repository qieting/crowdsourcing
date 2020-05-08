import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:crowdsourcing/channel/QQChannel.dart';
import 'package:crowdsourcing/common/IM.dart';
import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:crowdsourcing/models/OrderModel/OffineOrderModel.dart';
import 'package:crowdsourcing/models/OrderModel/OffineOrderingModel.dart';
import 'package:crowdsourcing/models/OrderModel/OnlineOrderModel.dart';
import 'package:crowdsourcing/models/OrderModel/OnlineOrderingModel.dart';
import 'package:crowdsourcing/models/OrderShowHelp/OffineOrderWithPeople.dart';
import 'package:crowdsourcing/models/OrderShowHelp/OnlineOrderWithPeople.dart';
import 'package:crowdsourcing/models/UserModel/LocationModel.dart';
import 'package:crowdsourcing/models/UserModel/UserModel.dart';

import 'package:crowdsourcing/models/object/order/offine/OffineOrder.dart';
import 'package:crowdsourcing/models/object/order/offine/OffineOrdering.dart';
import 'package:crowdsourcing/models/object/order/offine/location/Location.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrder.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrdering.dart';
import 'package:crowdsourcing/models/object/user.dart';
import 'package:crowdsourcing/net/MyUrl.dart';
import 'package:crowdsourcing/pages/MyHome/MyHomePage.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

//url访问

class MyDio {
  //单一dio实例，持有token
  static Dio dio;

  //使用token来做到登陆状态保持
  static const String Token = "token";
  static String token;

  //初始化
  static init() async {
    //从内存读取token
    token = await StorageManager.localStorage.getItem(Token);
    dio = Dio(BaseOptions(
        connectTimeout: 3000,
        baseUrl: MyUrl.baseUrl,
        headers: token == null ? {} : {Token: token}))
    //这里连缀调用增加拦截器，如果请求没有token并且不是登录请求，那么就抛出异常，实际上基本没有这种情况
      ..interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        if (!options.headers.containsKey(Token) &&
            !options.uri.toString().contains("people")) {
          throw UnTokenException();
        }
      }, onError: (DioError e) {
        //对异常进行处理，这里主要是进行tast提示,然后具体请求会输出异常发生的信息
        _disposeDioError(e);
      }));
  }

  //对异常进行处理，这里主要是进行tast提示,然后具体请求会输出异常发生的信息
  static _disposeDioError(DioError e) {
    switch (e.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        MyToast.toast(DemoLocalizations.demoLocalizations.connectionTimeout);
        break;
      case DioErrorType.SEND_TIMEOUT:
        MyToast.toast(DemoLocalizations.demoLocalizations.sendTimeout);
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        MyToast.toast(DemoLocalizations.demoLocalizations.receiveTimeout);
        break;
      case DioErrorType.RESPONSE:
        switch (e.response.statusCode) {
          case 200:
            break;
          case 401:
            MyToast.toast(DemoLocalizations.demoLocalizations.status401);
            break;
          case 417:
            MyToast.toast(DemoLocalizations.demoLocalizations.status407);
            break;
          case 500:
            MyToast.toast(DemoLocalizations.demoLocalizations.status500);
            break;
          default:
            MyToast.toast(
                DemoLocalizations.demoLocalizations.statusOhters + e.message);
            break;
        }
        break;
      case DioErrorType.CANCEL:
        MyToast.toast(DemoLocalizations.demoLocalizations.accessDenied);
        break;

      case DioErrorType.DEFAULT:
        MyToast.toast((e.error?.toString()) ?? e.message);
        break;
    }
  }

  static printDioError(String functionNume, DioError e) {
    print("异常位置$functionNume,错误信息为" + e.message);
  }

  static initPeopleMessage(body,context){
    User user = User.fromJsonMap(body['message']);
    Provider.of<UserModel>(context, listen: false).saveUser(user);
    //解析location
    List<Location> list = [];
    if (body['locations'] != null) {
      for (var location in body['locations']) {
        list.add(Location.fromJsonMap(location));
      }
    }
    Provider.of<LocationModel>(context, listen: false).addLocations(list);
    //解析离线订单消息
    List<OffineOrdering> list1 =
    (body['offineOrdering'] as List).map<OffineOrdering>((f) {
      return OffineOrdering.fromJsonMap(f);
    }).toList();
    Provider.of<OffineOrderingModel>(context, listen: false)
        .addOffineOrderings(list1);
    //解析离线订单
    List<OffineOrder> list2 =
    (body['offineOrder'] as List).map<OffineOrder>((f) {
      return OffineOrder.fromJsonMap(f);
    }).toList();
    Provider.of<OffineOrderModel>(context, listen: false)
        .addOffineOrders(list2);
    //解析在线订单
    List<OnlineOrder> list3 =
    (body['onlineOrder'] as List).map<OnlineOrder>((f) {
      return OnlineOrder.fromJsonMap(f);
    }).toList();
    Provider.of<OnlineOrderModel>(context, listen: false)
        .addOnlineOrders(list3);
    //解析在线订单接单
    List<OnlineOrdering> list4 =
    (body['onlineOrdering'] as List).map<OnlineOrdering>((f) {
      return OnlineOrdering.fromJsonMap(f);
    }).toList();
    Provider.of<OnlineOrderingModel>(context, listen: false)
        .addOnlineOrderings(list4);
  }

  //登录，利用token直接获取个人信息
  static getPeople(BuildContext context) async {
    try {
      Response response = await dio.get(MyUrl.people);
      //这里会自动解析response的数据，我们服务器传过来的是map，所以这里data会被自动解析为map
      var body = response.data;

      initPeopleMessage(body, context);
      return true;
    } on DioError catch (e) {
      printDioError("login", e);
      return false;
    } catch (e) {
      print("login程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
      return false;
    }
  }

  //更改个人信息
  static Future<bool> changeMessage(Map map) async {
    try {
      Response response = await dio.put(MyUrl.people, data: map);

      var body = json.decode(response.toString());
      User user = User.fromJsonMap(body);
      Provider.of<UserModel>(MyHomePage.of().context, listen: false).saveUser(user);
      //Routers.pushAndRemove(context, Routers.MYHOMEPAGE);
    } on DioError catch (e) {
      printDioError("changeMessage", e);
      return false;
    } catch (e) {
      print("changeMessage程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
      return false;
    }
  }

  //登录 ，其中map内可以包括账号密码，QQ号,以及仅仅手机号（短信登陆）
  static Login(Map map,
      {BuildContext context, Function success(), failed}) async {
    try {
      //在这里因为可能有mytoast，而mytoast是在系统输入框下的，因此这里先隐藏输入框，让toast可以显示出来
      FocusScope.of(context).unfocus();
      Response response = await dio.post(MyUrl.people, data: map);
      var body = json.decode(response.toString());
      //登陆失败时
      if (body['status'] < 0) {
        Fluttertoast.showToast(msg: body['message']);
        failed();
        return;
      }

      token = body['token'];
      dio.options.headers[Token] = token;
      StorageManager.localStorage.setItem(Token, token);

      User user = User.fromJsonMap(body['message']);
      Provider.of<UserModel>(context, listen: false).saveUser(user);

      //判断是否是QQ的新注册用户，如果是，那么QQ获取相应信息
      //否则则解析数据
      if (body['register'] != null && User.QQ != null) {
        await QQChannel.qqMessage();
        Routers.pushAndRemove(context, Routers.MYHOMEPAGE);
      } else {
        List<Location> list = (body['location'] as List).map<Location>((f) {
          return Location.fromJsonMap(f);
        }).toList();
        Provider.of<LocationModel>(context, listen: false).addLocations(list);
        List<OffineOrdering> list1 =
        (body['offineOrdering'] as List).map<OffineOrdering>((f) {
          return OffineOrdering.fromJsonMap(f);
        }).toList();
        Provider.of<OffineOrderingModel>(context, listen: false)
            .addOffineOrderings(list1);
        List<OffineOrder> list2 =
        (body['offineOrder'] as List).map<OffineOrder>((f) {
          return OffineOrder.fromJsonMap(f);
        }).toList();
        Provider.of<OffineOrderModel>(context, listen: false)
            .addOffineOrders(list2);

        List<OnlineOrder> list3 =
        (body['onlineOrder'] as List).map<OnlineOrder>((f) {
          return OnlineOrder.fromJsonMap(f);
        }).toList();
        Provider.of<OnlineOrderModel>(context, listen: false)
            .addOnlineOrders(list3);
        List<OnlineOrdering> list4 =
        (body['onlineOrdering'] as List).map<OnlineOrdering>((f) {
          return OnlineOrdering.fromJsonMap(f);
        }).toList();
        Provider.of<OnlineOrderingModel>(context, listen: false)
            .addOnlineOrderings(list4);
        Routers.pushAndRemove(context, Routers.MYHOMEPAGE);
      }
    } on DioError catch (e) {
      if (failed != null) {
        failed();
      }
      printDioError("login", e);
    } catch (e) {
      if (failed != null) {
        failed();
      }
      print("login程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

//增加线下订单收货地址
  static addLocation(Location location, {BuildContext context}) async {
    try {
      FocusScope.of(context).unfocus();
      Response response =
      await dio.post(MyUrl.location, data: location.toJson());

      Provider.of<LocationModel>(context, listen: false).addLocation(location);
      MyToast.toast("增加位置信息成功");
    } on DioError catch (e) {
      printDioError("addLocation", e);
    } catch (e) {
      print("addLocation程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

  //更改线下订单位置
  static changeLocation(Location location,
      {BuildContext context, Function success()}) async {
    try {
      Response response =
      await dio.put(MyUrl.location, data: location.toJson());
      MyToast.toast("修改位置信息成功");
    } on DioError catch (e) {
      printDioError("changeLocation", e);
    } catch (e) {
      print("changeLocation程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

  //删除线下订单
  static deleteLocation(int id, {Function success()}) async {
    try {
      //FocusScope.of(context).unfocus();
      Response response = await dio.delete(MyUrl.location,
          data: new Map<String, dynamic>.from({'id': id}));
      MyToast.toast("删除成功");
    } on DioError catch (e) {
      printDioError("deleteLocation", e);
    } catch (e) {
      print("deleteLocation程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

  //增加线下订单
  static addOffineOrder(OffineOrder offineOrder,
      {BuildContext context, Function success}) async {
    try {
      Response response =
      await dio.post(MyUrl.offineOrder, data: offineOrder.toJson());

      MyToast.toast("增加成功");
      Provider.of<OffineOrderModel>(context, listen: false)
          .addOffineOrder(offineOrder);
      success();
    } on DioError catch (e) {
      printDioError("addOffineOrder", e);
    } catch (e) {
      print("addOffineOrder程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

  //结束线下订单，策略是如果已经被接，就直接给钱，否则退钱给用户
  static finishOffineOrder(int offineOrderId,context) async {
    try {
      Response response =
      await dio.put(MyUrl.offineOrder,  queryParameters:{"offineOrderId":offineOrderId});
      initPeopleMessage(response.data, context);
      MyToast.toast("结束任务成功");
    } on DioError catch (e) {
      printDioError("finishOffineOrder", e);
    } catch (e) {
      print("finishOffineOrder程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

  //获取线下订单列表，没有使用，因为改为主动获取所有所有列表
  static getOffineOrders(BuildContext context, Function success) async {
    try {
      int paltForm = Platform.isAndroid ? 1 : 2;
      Response response = await dio.get(MyUrl.offineOrder,
          queryParameters: {'platForm': paltForm.toString()});

      var body = response.data;
      List<OffineOrder> offineOrders = body.map<OffineOrder>((it) {
        return OffineOrder.fromJsonMap(it);
      }).toList();
      success(offineOrders);
    } on DioError catch (e) {
      printDioError("getOffineOrders", e);
    } catch (e) {
      print("getOffineOrders程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

  //根据平台获取线下线上的订单
  static getOrders(BuildContext context, Function success) async {
    try {
      int paltForm = Platform.isAndroid ? 1 : 2;
      Response response = await dio
          .get(MyUrl.order, queryParameters: {'platForm': paltForm.toString()});
      var body = response.data;
      List<OffineOrderWithPeople> offineOrderWithPeoples =
      (body["offineOrder"] as List).map<OffineOrderWithPeople>((it) {
        return OffineOrderWithPeople(User.fromJsonMap(it['user']),
            OffineOrder.fromJsonMap(it['offineOrder']));
      }).toList();
      List<OnlineOrderWithPeople> onlineOrderWithPeoples =
      (body["onlineOrder"] as List).map<OnlineOrderWithPeople>((it) {
        return OnlineOrderWithPeople(User.fromJsonMap(it['user']),
            OnlineOrder.fromJsonMap(it['onLineOrder']));
      }).toList();
      success(offineOrderWithPeoples, onlineOrderWithPeoples);
    } on DioError catch (e) {
      printDioError("getOrders", e);
    } catch (e) {
      print("getOrders程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

  //根据类型和线上线下获取自己的相关订单
  static Future<List> getTakeOrders(BuildContext context, int type,
      bool online) async {
    try {
      Response response = await dio.get(MyUrl.takeOrder,
          queryParameters: {'type': type, "online": online});

      return (response.data as List);
    } on DioError catch (e) {
      printDioError("getTakeOrders", e);
    } catch (e) {
      print("getTakeOrders程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

  //新增离线订单接单信息
  static addOffineOrdering(int offerding,
      {BuildContext context, Function success}) async {
    try {
      Response response = await dio.post(MyUrl.offineOrdering, data: offerding);
      success(response.data);
    } on DioError catch (e) {
      printDioError("addOffineOrdering", e);
    } catch (e) {
      print("addOffineOrdering程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

  //离线订单完成
  static changeOffineOrdering(int offineOrderId,
      {BuildContext context, Function success()}) async {
    try {
      //FocusScope.of(context).unfocus();
      Response response = await dio.put(MyUrl.offineOrdering,
          queryParameters: {"offineOrderId": offineOrderId});

      success();
    } on DioError catch (e) {
      printDioError("changeOffineOrdering", e);
    } catch (e) {
      print("changeOffineOrdering程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

  //获取某个离线order的所有订单
  static Future<Map> getOffineOrderingByOrderId(BuildContext context,
      int orderId) async {
    try {
      Response response = await dio
          .get(MyUrl.offineOrdering, queryParameters: {'orderid': orderId});
      return response.data;
    } on DioError catch (e) {
      printDioError("getOffineOrderingByOrderId", e);
    } catch (e) {
      print("getOffineOrderingByOrderId程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

  //获取图片
  static Future<Response> getImage(String filePath) async {
    try {
      Response response = await dio.get(MyUrl.images + filePath,
          options: Options(responseType: ResponseType.bytes));

      return response;
    } on DioError catch (e) {
      printDioError("getImage", e);
    } catch (e) {
      print("getImage程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

  //上传图片
  static Future<String> upImage(String filePath) async {
    try {
      FormData formData = new FormData.from({
        "file": UploadFileInfo(new File(filePath),
            filePath.split("/")[filePath
                .split("/")
                .length - 1])
      });
      Response response = await dio.post(MyUrl.imageUp, data: formData);

      return response.data;
    } on DioError catch (e) {
      printDioError("getImage", e);
    } catch (e) {
      print("getImage程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

  //增加在线订单，包含需要上传的图片
  static addOnlineOrder(OnlineOrder onlineOrder,
      {BuildContext context, Function success}) async {
    try {
      Map<String, dynamic> map = new Map();
      //这里采用上传了图片数组的形式，同时这里因为有些步骤并没有图片，因此后面需要remove 空的
      map.addAll({
        'files': onlineOrder.onlineSteps.map<UploadFileInfo>((it) {
          if (it.imageUrl != null)
            return UploadFileInfo(new File(it.imageUrl),
                it.imageUrl.split("/")[it.imageUrl
                    .split("/")
                    .length - 1]);
        }).toList()
        //除空
          ..removeWhere((test) {
            if (test == null)
              return true;
            else
              return false;
          })
      });
      OnlineOrder oo =OnlineOrder.fromJsonMap(onlineOrder.toJson());
      oo.onlineSteps.forEach((it) {
        if (it.imageUrl != null)
          it.imageUrl =
          it.imageUrl.split("/")[it.imageUrl
              .split("/")
              .length - 1];
      });
      map.addAll(oo.toJson());

      FormData formData = new FormData.from(map);
      Response response = await dio.post(MyUrl.onlineOrder, data: formData);
      if(response.data is String){
        MyToast.toast("余额不足");
        return ;
      }
      MyToast.toast("增加成功");
      onlineOrder = OnlineOrder.fromJsonMap(response.data);
      Provider.of<OnlineOrderModel>(context, listen: false)
          .addOnlineOrder(onlineOrder);
      success(onlineOrder);
    } on DioError catch (e) {
      printDioError("addOnlineOrder", e);
    } catch (e) {
      print("addOnlineOrder程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }
  //结束线下订单，策略是如果已经被接，就直接给钱，否则退钱给用户
  static changeOnlineOrder(int onLineOrderId,context) async {
    try {
      Response response =
      await dio.put(MyUrl.onlineOrder, queryParameters:{"onlineOrderId":onLineOrderId});
      initPeopleMessage(response.data, context);
      MyToast.toast("结束任务成功");
    } on DioError catch (e) {
      printDioError("finishOffineOrder", e);
    } catch (e) {
      print("finishOffineOrder程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }


  //增加线上任务接单
  static addOnlineOrdering(int offerding,
      {BuildContext context, Function success}) async {
    try {
      Response response = await dio.post(MyUrl.onlineOrdering, data: offerding);
      success(response.data);
    } on DioError catch (e) {
      printDioError("addOnlineOrdering", e);
    } catch (e) {
      print("addOnlineOrdering程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

  //结束线上任务接单
  static finishOnlineOrdering(context, int onlineOrderId, bool check,
      String reason, success) async {
    try {
      //FocusScope.of(context).unfocus();
//      Map<String, dynamic> map = {"orderingId": onlineOrderId};
//     map["check"]=check;
//     map["reason"]=reason??"";
      Response response = await dio.put(MyUrl.finishonlineOrdering,
          queryParameters: {
            "orderingId": onlineOrderId,
            "check": check,
            "reason": reason ?? ""
          });

      success(response.data);
    } on DioError catch (e) {
      printDioError("finishOnlineOrdering", e);
    } catch (e) {
      print("finishOnlineOrdering程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

  static changeOnlineOrdering(int onlineOrderId, Map images, Map phones,
      {BuildContext context, @required success}) async {
    try {
      //FocusScope.of(context).unfocus();
      Map<String, dynamic> map = {"onlineOrderId": onlineOrderId};
      map.addAll(phones.map((k, v) {
        return MapEntry(k.toString(), v);
      }));
      map.addAll(images.map<String, UploadFileInfo>((k, v) {
        return MapEntry(k.toString(),
            UploadFileInfo(File(v), v.split("/")[v
                .split("/")
                .length - 1]));
      }));
      FormData formData = new FormData.from(map);
      Response response = await dio.put(MyUrl.onlineOrdering, data: formData);

      success(OnlineOrdering.fromJsonMap(response.data));
    } on DioError catch (e) {
      printDioError("changeOnlineOrdering", e);
    } catch (e) {
      print("changeOnlineOrdering程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }

  static Future<Map> getOnlineOrderingByOrderId(BuildContext context,
      int orderId) async {
    try {
      Response response = await dio
          .get(MyUrl.onlineOrdering, queryParameters: {'orderid': orderId});

      return response.data;
    } on DioError catch (e) {
      printDioError("getOnlineOrderingByOrderId", e);
    } catch (e) {
      print("getOnlineOrderingByOrderId程序内部发生错误,$e");
      MyToast.toast(DemoLocalizations.demoLocalizations.bug+",$e");
    }
  }


}

//没有token
class UnTokenException implements Exception {
  const UnTokenException();

  @override
  String toString() => 'UnAuthorizedException';
}
