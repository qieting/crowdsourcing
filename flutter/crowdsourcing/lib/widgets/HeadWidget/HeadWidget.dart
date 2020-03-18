import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeadWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      decoration: BoxDecoration(color: Theme.of(context).appBarTheme.color),
      padding: const EdgeInsets.only(left: 40, top: 5, bottom: 5, right: 0),
      child: Consumer<UserModel>(builder: (context, userModel, child) {
        return Row(
          children: <Widget>[
            Image(
              image: userModel.user?.head == null
                  ? AssetImage("assets/images/deafaultHead.png")
                  : NetworkImage(userModel.user.head),
              height: 80,
              width: 70,
              fit: BoxFit.contain,
            ),
            Container(
              padding: const EdgeInsets.only(left: 50, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    userModel.user?.nick??"昵称为空",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    userModel.user?.phone ?? "未绑定手机号",
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        fontSize: 13),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  MyToast.toast("dianj");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.chevron_right,
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(85);
}
