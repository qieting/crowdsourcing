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
    Future.delayed(new Duration(milliseconds: 0), () async {
     Routers.pushAndRemove(context, Routers.MYHOMEPAGE);
//      if (MyDio.token == null) {
//        Routers.pushAndRemove(context, Routers.LOGIN);
//      } else {
//        bool success = await MyDio.getPeople(context);
//        if (success) {
//          return Routers.pushAndRemove(context, Routers.MYHOMEPAGE,
//              params: {'title': 'hi'});
//        } else {
//          return Routers.pushAndRemove(context, Routers.LOGIN);
//        }
//      }
    });

    return Center(
      child: Scaffold(
        body: Container(
            child: Center(child: Text(DemoLocalizations.of(context).guanggao))),
      ),
    );
  }
}
