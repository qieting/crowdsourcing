import 'package:crowdsourcing/common/IM.dart';
import 'package:crowdsourcing/common/ListNotify.dart';
import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MessagePageState();
  }
}

class MessagePageState extends State<MessagePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  ListNotify<Conversation> conversationList = IM.conversationList;
  String myId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    conversationList.addListener(() {
      print("会话列表有新更新");
      setState(() {});
    });
  }

  @override
  didChangeDependencies() async {
    myId = Provider.of<UserModel>(context).user.id.toString();
  }

  Future<Map> getOnlineOrderingByOrderId() async {
    return await MyDio.getOnlineOrderingByOrderId(context, 0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //必须添加
    return FutureBuilder<Map>(
      future: getOnlineOrderingByOrderId(),
      builder: (context, AsyncSnapshot<Map> asyncSnapshot) {
        switch (asyncSnapshot.connectionState) {
          case ConnectionState.none:
          // TODO: Handle this case.
          case ConnectionState.active:
          // TODO: Handle this case.
          case ConnectionState.waiting:
            return before();
            // TODO: Handle this case.
            break;

          case ConnectionState.done:
            return before();
            break;
          default:
            return before();
            break;
        }
      },
    );
  }

  Widget before() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: GestureDetector(
              onTap: () async {
                Routers.push(context, Routers.CHATPAGE, params: {
                  "id": int.parse(conversationList[index].senderUserId == myId
                      ? conversationList[index].targetId
                      : conversationList[index].senderUserId)
                });
              },
              child: Row(
                children: <Widget>[
                  Image(
                    height: 70,
                    width: 70,
                    image: AssetImage("assets/images/deafaultHead.png"),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: <Widget>[
                      Text(conversationList[index].senderUserId == myId
                          ? conversationList[index].targetId
                          : conversationList[index].senderUserId),
                      Text(conversationList[index]
                          .latestMessageContent
                          .conversationDigest())
                    ],
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: conversationList.length);
  }
}
