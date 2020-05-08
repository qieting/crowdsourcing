import 'package:crowdsourcing/common/StorageManager.dart';
import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:crowdsourcing/models/ViewThemeModel/ViewThemeModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routers.dart';
import 'MyHome/MyHomePage.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 15,bottom: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.only(left: 15),
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                        text: "主题色",
                      ),
                      TextSpan(
                          text: " (18色可选)",
                          style: TextStyle(color: Colors.grey[400]))
                    ])),
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white),
                    height: 40,
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 15,
                        );
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Provider.of<ViewThemeModel>(context, listen: false)
                                .changeColor(index);
                          },
                          child: Container(
                            width: 50,
                            height: 40,
                            decoration:
                                BoxDecoration(color: Colors.primaries[index]),
                          ),
                        );
                      },
                      itemCount: Colors.primaries.length,
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 15),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                height: 40,
                margin: const EdgeInsets.only(top: 15),
                child: Row(
                  children: <Widget>[
                    Text("是否跟随系统选择深色模式"),
                    Expanded(
                      child: SizedBox()
                    ),
                    Consumer<ViewThemeModel>(
                        builder: (context, viewThemeMode, child) {
                      return Switch(
                        value: viewThemeMode.viewTheme.drakModelFollow,
                        onChanged: (value) {
                          viewThemeMode.changeDarkModeFlow(value);
                        },
                      );
                    })
                  ],
                )),
            Container(
                padding: const EdgeInsets.only(left: 15),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                height: 40,
                margin: const EdgeInsets.only(top: 15),
                child: FlatButton(
                  child: Text("退出登录"),
                  onPressed: (){

                    Navigator.of(context).pop();
                    Provider.of<UserModel>(context,listen: false).clearUser();
                    StorageManager.localStorage.clear();
                    Routers.pushAndRemove(MyHomePage.of().context, Routers.LOGIN);
                  },
                )
            )
          ],
        ),
      ),
    );
  }
}
