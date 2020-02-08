import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:crowdsourcing/models/object/user.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//        var userMap = StorageManager.localStorage?.getItem(UserModel.userS);
//    User _user = userMap != null ? User.fromJsonMap(userMap) : null;
////      _user=new User();
////      _user.phone="10";
//    print(Provider.of<UserModel>(context).hasUser);
//    Provider.of<UserModel>(context, listen: false).saveUser(_user);
//    print(Provider.of<UserModel>(context, listen: false).hasUser);
//    Future.delayed(Duration(seconds: 2), () {
//      //该方法是跳转后不再返回
//      //如果单纯调用pop销毁该界面，那么在下一个界面返回就是黑屏
//      Navigator.of(context).pushAndRemoveUntil(
//          MaterialPageRoute(builder: (context) {
//            //这里根据是否有user进行不同的跳转
//            if (_user != null) {
//              return Routers.getPage(Routers.MYHOMEPAGE, params: {'title': 'hi'});
//            } else {
//              return Routers.getPage(Routers.LOGIN);
//            }
//          }), (route) => route == null);
//      //      Routers.pushAndRe(context, Routers.MYHOMEPAGE, params: {'title': 'hi'});
//      //      Navigator.pop(context);
//    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print("didChange");
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    print("deactive");
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(builder: (context, usermodel, child) {
      Future.delayed(Duration(seconds: 2), () {
        //该方法是跳转后不再返回
        //如果单纯调用pop销毁该界面，那么在下一个界面返回就是黑屏
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
              //这里根据是否有user进行不同的跳转
              if (usermodel.hasUser) {
                return Routers.getPage(Routers.MYHOMEPAGE, params: {'title': 'hi'});
              } else {
                return Routers.getPage(Routers.LOGIN);
              }
            }), (route) => route == null);
        //      Routers.pushAndRe(context, Routers.MYHOMEPAGE, params: {'title': 'hi'});
        //      Navigator.pop(context);
      });
      return Scaffold(
        body: Container(
            child: Center(child: Text(DemoLocalizations.of(context).guanggao))),
      );
    });
  }
}
