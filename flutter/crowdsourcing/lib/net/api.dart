import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:crowdsourcing/channel/QQChannel.dart';
import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:crowdsourcing/models/OrderModel/OffineOrderModel.dart';
import 'package:crowdsourcing/models/OrderModel/OffineOrderingModel.dart';
import 'package:crowdsourcing/models/OrderModel/OnlineOrderModel.dart';
import 'package:crowdsourcing/models/OrderModel/OnlineOrderingModel.dart';
import 'package:crowdsourcing/models/UserModel/LocationModel.dart';
import 'package:crowdsourcing/models/UserModel/UserModel.dart';

import 'package:crowdsourcing/models/object/order/offine/OffineOrder.dart';
import 'package:crowdsourcing/models/object/order/offine/OffineOrdering.dart';
import 'package:crowdsourcing/models/object/order/offine/location/Location.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrder.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrdering.dart';
import 'package:crowdsourcing/models/object/user.dart';
import 'package:crowdsourcing/net/MyUrl.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MyDio {
  static Dio dio;
  static const String Token = "token";

  static String token;

  static init() async {
    //从内存读取token
    token = await StorageManager.localStorage.getItem(Token);
    dio = Dio(BaseOptions(
        connectTimeout: 5000,
        baseUrl: MyUrl.baseUrl,
        headers: token == null ? {} : {Token: token}));
    //这里增加拦截器，如果请求没有token并且不是登录请求，那么就抛出异常，实际上基本没有这种情况
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      if (!options.headers.containsKey(Token) &&
          !options.uri.toString().contains("people")) {
        throw UnTokenException();
      }
    }));
  }

  static getPeople(BuildContext context) async {
    try {
      Response response = await dio.get(MyUrl.people);
      if (response.statusCode == 200) {
        var body = json.decode(response.toString());
        User user = User.fromJsonMap(body['message']);
        Provider.of<UserModel>(context, listen: false).saveUser(user);

        List<Location> list = [];

        if (body['locations'] != null) {
          for (var location in body['locations']) {
            list.add(Location.fromJsonMap(location));
          }
        }

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

        return true;
      } else {
        MyToast.toast(failStatus(response.statusCode));
        return false;
      }
    } catch (e) {
      print(e);
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
      return false;
    }
  }

  static changeMessage(Map map, BuildContext context) async {
    try {
      Response response = await dio.put(MyUrl.people, data: map);
      if (response.statusCode == 200) {
        var body = json.decode(response.toString());
        User user = User.fromJsonMap(body);
        Provider.of<UserModel>(context, listen: false).saveUser(user);
      } else {
        MyToast.toast(failStatus(response.statusCode));
      }
    } catch (e) {
      print(e);
    }
  }

  static failStatus(int status) {
    switch (status) {
      case 200:
        return true;
        break;
      case 401:
        return DemoLocalizations.demoLocalizations.status401;
        break;
      case 417:
        return DemoLocalizations.demoLocalizations.status407;
      case 500:
        return DemoLocalizations.demoLocalizations.status500;
        break;
      default:
        return DemoLocalizations.demoLocalizations.statusOhters +
            status.toString();
        break;
    }
  }

  static Login(Map map,
      {BuildContext context, Function success(), failed}) async {
    try {
      FocusScope.of(context).unfocus();
      Response response = await dio.post(MyUrl.people, data: map);
      if (response.statusCode == 200) {
        var body = json.decode(response.toString());
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

        if (body['register'] != null) {
          QQChannel.qqMessage();
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
        }
        Routers.pushAndRemove(context, Routers.MYHOMEPAGE,
            params: {"title": "as"});
      } else {
        failed();
        showError(context, failStatus(response.statusCode));
      }
    } catch (e) {
      if (failed != null) failed();
      print(e);
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
    }
  }

  static addLocation(Location location,
      {BuildContext context, Function success()}) async {
    try {
      FocusScope.of(context).unfocus();
      Response response =
          await dio.post(MyUrl.location, data: location.toJson());
      if (response.statusCode == 200) {
        Provider.of<LocationModel>(context, listen: false)
            .addLocation(location);
        MyToast.toast("增加位置信息成功");
      } else {
        showError(context, failStatus(response.statusCode));
      }
    } catch (e) {
      print(e);
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
    }
  }

  static changeLocation(Location location,
      {BuildContext context, Function success()}) async {
    try {
      //FocusScope.of(context).unfocus();
      Response response =
          await dio.put(MyUrl.location, data: location.toJson());
      if (response.statusCode == 200) {
//        Provider.of<LocationModel>(context, listen: false)
//            .addLocation(location);
//        MyToast.toast("增加位置信息成功");
      } else {
        showError(context, failStatus(response.statusCode));
      }
    } catch (e) {
      print(e.toString());
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
    }
  }

  static deleteLocation(int id, {Function success()}) async {
    try {
      //FocusScope.of(context).unfocus();
      Response response = await dio.delete(MyUrl.location,
          data: new Map<String, dynamic>.from({'id': id}));
      if (response.statusCode == 200) {
        MyToast.toast("删除成功");
      } else {
        MyToast.toast(failStatus(response.statusCode));
      }
    } catch (e) {
      print(e.toString());
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
    }
  }

  static addOffineOrder(OffineOrder offineOrder,
      {BuildContext context, Function success}) async {
    try {
      print(1.toString());
      Response response =
          await dio.post(MyUrl.offineOrder, data: offineOrder.toJson());
      if (response.statusCode == 200) {
        MyToast.toast("增加成功");
        Provider.of<OffineOrderModel>(context, listen: false)
            .addOffineOrder(offineOrder);
        success();
      } else {
        showError(context, failStatus(response.statusCode));
      }
    } catch (e) {
      print(e);
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
    }
  }

  static getOffineOrders(BuildContext context, Function success) async {
    try {
      int paltForm = Platform.isAndroid ? 1 : 2;
      Response response = await dio.get(MyUrl.offineOrder,
          queryParameters: {'platForm': paltForm.toString()});
      if (response.statusCode == 200) {
        var body = response.data;
        List<OffineOrder> offineOrders = body.map<OffineOrder>((it) {
          return OffineOrder.fromJsonMap(it);
        }).toList();
        success(offineOrders);
      } else {
        MyToast.toast(failStatus(response.statusCode));
        return false;
      }
    } catch (e) {
      print(e);
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
      return false;
    }
  }

  static getOrders(BuildContext context, Function success) async {
    try {
      int paltForm = Platform.isAndroid ? 1 : 2;
      Response response = await dio
          .get(MyUrl.order, queryParameters: {'platForm': paltForm.toString()});
      if (response.statusCode == 200) {
        var body = response.data;
        List<OffineOrder> offineOrders =
            (body["offineOrder"] as List).map<OffineOrder>((it) {
          return OffineOrder.fromJsonMap(it);
        }).toList();
        List<OnlineOrder> onlineOrders =
            (body["onlineOrder"] as List).map<OnlineOrder>((it) {
          return OnlineOrder.fromJsonMap(it);
        }).toList();
        success(offineOrders, onlineOrders);
      } else {
        MyToast.toast(failStatus(response.statusCode));
        return false;
      }
    } catch (e) {
      print(e);
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
      return false;
    }
  }

  static addOffineOrdering(int offerding,
      {BuildContext context, Function success}) async {
    try {
      Response response = await dio.post(MyUrl.offineOrdering, data: offerding);
      if (response.statusCode == 200) {
        success(response.data);
      } else {
        showError(context, failStatus(response.statusCode));
      }
    } catch (e) {
      print(e);
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
    }
  }

  static changeOffineOrdering(int offineOrderId,
      {BuildContext context, Function success()}) async {
    try {
      //FocusScope.of(context).unfocus();
      Response response = await dio
          .put(MyUrl.offineOrdering, data: {"offineOrderId": offineOrderId});
      if (response.statusCode == 200) {
        success();
      } else {
        showError(context, failStatus(response.statusCode));
      }
    } catch (e) {
      print(e.toString());
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
    }
  }
  static Future<Map> getOffineOrderingByOrderId(BuildContext context,int orderId) async {
    try {
      Response response = await dio.get(MyUrl.offineOrdering,
          queryParameters: {'orderid': orderId});
      if (response.statusCode == 200) {
        return response.data;
      } else {
        MyToast.toast(failStatus(response.statusCode));
        return null;
      }
    } catch (e) {
      print(e);
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
      return null;
    }
  }

  static Future<Response> getImage(String filePath) async {
    try {
      Response response = await dio.get(MyUrl.imageUp + filePath,
          options: Options(responseType: ResponseType.bytes));
      if (response.statusCode == 200) {
        return response;
      } else {
        MyToast.toast(failStatus(response.statusCode));
      }
    } catch (e) {
      print(e);
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
    }
  }

  static Future<String> FileUp(File file, String fileName,
      {BuildContext context, Function success}) async {
    try {
      Response response = await dio.post(
        MyUrl.imageUp,
        data: UploadFileInfo(file, fileName),
      );
      if (response.statusCode == 200) {
        return response.data['url'];
      } else {
        showError(context, failStatus(response.statusCode));
      }
    } catch (e) {
      print(e);
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
    }
  }

  static addOnlineOrder(OnlineOrder onlineOrder,
      {BuildContext context, Function success}) async {
    try {
      Map<String, dynamic> map = new Map();

      map.addAll({
        'files': onlineOrder.onlineSteps.map<UploadFileInfo>((it) {
          if (it.imageUrl != null)
            return UploadFileInfo(new File(it.imageUrl),
                it.imageUrl.split("/")[it.imageUrl.split("/").length - 1]);
        }).toList()
          ..remove(null)
          ..remove(null)
          ..remove(null)
          ..remove(null)
      });
      onlineOrder.onlineSteps.forEach((it) {
        if (it.imageUrl != null)
          it.imageUrl =
              it.imageUrl.split("/")[it.imageUrl.split("/").length - 1];
      });
      map.addAll(onlineOrder.toJson());
      FormData formData = new FormData.from(map);
      Response response = await dio.post(MyUrl.onlineOrder, data: formData);
      if (response.statusCode == 200) {
        MyToast.toast("增加成功");
        OnlineOrder onlineOrder = OnlineOrder.fromJsonMap(response.data);
        Provider.of<OnlineOrderModel>(context, listen: false)
            .addOnlineOrder(onlineOrder);
        success(onlineOrder);
      } else {
        showError(context, failStatus(response.statusCode));
      }
    } catch (e) {
      print(e);
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
    }
  }

  static addOnlineOrdering(int offerding,
      {BuildContext context, Function success}) async {
    try {
      Response response = await dio.post(MyUrl.onlineOrdering, data: offerding);
      if (response.statusCode == 200) {
        success(response.data);
      } else {
        showError(context, failStatus(response.statusCode));
      }
    } catch (e) {
      print(e);
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
    }
  }

  static finishOnlineOrdering(context,int onlineOrderId,bool check ,String reason,success) async{
    try {
      //FocusScope.of(context).unfocus();
      Map<String, dynamic> map = {"orderingId": onlineOrderId};
     map["check"]=check;
     map["reason"]=reason;

      Response response = await dio.put(MyUrl.onlineOrdering, data:map);
      if (response.statusCode == 200) {
        success(OnlineOrdering.fromJsonMap(response.data));
      } else {
        showError(context, failStatus(response.statusCode));
      }
    } catch (e) {
      print(e.toString());
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
    }
  }

  static changeOnlineOrdering(int onlineOrderId, Map images, Map phones,
      {BuildContext context,@required success}) async {
    try {
      //FocusScope.of(context).unfocus();
      Map<String, dynamic> map = {"onlineOrderId": onlineOrderId};
      map.addAll(phones.map((k,v){return MapEntry(k.toString(),v);}));
      map.addAll(images.map<String, UploadFileInfo>((k, v) {
        return MapEntry(
            k.toString(), UploadFileInfo(File(v), v.split("/")[v.split("/").length - 1]));
      }));
      FormData formData = new FormData.from(map);
      Response response = await dio.put(MyUrl.onlineOrdering, data: formData);
      if (response.statusCode == 200) {
        success(OnlineOrdering.fromJsonMap(response.data));
      } else {
        showError(context, failStatus(response.statusCode));
      }
    } catch (e) {
      print(e.toString());
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
    }
  }

  static Future<Map> getOnlineOrderingByOrderId(BuildContext context,int orderId) async {
    try {
      Response response = await dio.get(MyUrl.onlineOrdering,
          queryParameters: {'orderid': orderId});
      if (response.statusCode == 200) {
        return response.data;
      } else {
        MyToast.toast(failStatus(response.statusCode));
        return null;
      }
    } catch (e) {
      print(e);
      MyToast.toast(DemoLocalizations.demoLocalizations.networkAnomaly);
      return null;
    }
  }
}

class UnTokenException implements Exception {
  const UnTokenException();

  @override
  String toString() => 'UnAuthorizedException';
}
