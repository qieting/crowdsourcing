import 'package:crowdsourcing/i10n/messages_messages.dart';
import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:crowdsourcing/widgets/TextFiledHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final int targetId;
  List<Message> message;

  ChatPage(this.targetId, this.message);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController textEditingController = new TextEditingController();
  String myId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    myId = Provider.of<UserModel>(context).user.id.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("聊天"),
      ),
      body: Column(
        children: <Widget>[
         Expanded(
            child: Container(
                child: ListView.builder(
                    itemCount: widget.message.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: <Widget>[
                          widget.message[index].senderUserId == myId
                              ? Expanded(
                                  child: SizedBox(),
                                )
                              : SizedBox(
                                  width: 0,
                                ),
                          Expanded(
                              child: ListTile(
                                  title: Text(widget.message[index].content
                                      .conversationDigest())))
                        ],
                      );
                    })),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withAlpha(180),
            ),
            width: double.infinity,
            padding:
            const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                      controller: textEditingController,
                      maxLines: 4,
                      minLines: 1,
                      decoration: MyDecoration.copyBorder(InputDecoration(
                          contentPadding:
                          EdgeInsets.only(left: 15, top: 10, bottom: 10),
                          isDense: true,
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(100))))),
                    )),
                SizedBox(width: 8,),
                GestureDetector(
                  // padding: const EdgeInsets.only(),
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: Container(
                      height: 25,
                      alignment: Alignment.center,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Text(
                        "发送",
                        style: TextStyle(backgroundColor: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
     
    );
  }
}
