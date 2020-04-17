import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:crowdsourcing/models/object/user.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //在此处注册MyToast，因为MyToast的原理是在MaterialApp内有一个overlay浮层，
    //在main.drat里面的MaterialApp的builder的context是其父组件的context，不可以，然后我们又不想
    //在MaterialApp的builder里使用Builder，因此就在这里初始化
    MyToast.init(context);
    //在这里根据有无token进行登录活动
    //使用future是因为，我们当前正在处于build过程中，不能将当前组件设为dirty
    //因此我们使用future.delay，将这个跳转活动放到一个次于build的list，build后再运行这个方法
    Future.delayed(new Duration(milliseconds: 0), () async {
     // Routers.pushAndRemove(context, Routers.MYHOMEPAGE);
      if (MyDio.token == null) {
        Routers.pushAndRemove(context, Routers.LOGIN);
      } else {
        //这里有一个判断token是否可用的网络请求
        bool success = await MyDio.getPeople(context);
        if (success) {
          MyToast.toast("登陆成功");
          return Routers.pushAndRemove(context, Routers.MYHOMEPAGE);
        } else {
          return Routers.pushAndRemove(context, Routers.LOGIN);
        }
      }
    });

    return Center(
      child: Scaffold(
        body: Container(
            child: Center(child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                Text("加载中，请稍等")
              ],
            ),)),
      ),
    );
  }
}
