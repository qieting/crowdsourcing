import 'package:crowdsourcing/common/IM.dart';
import 'package:crowdsourcing/common/ListNotify.dart';
import 'package:crowdsourcing/i10n/messages_messages.dart';
import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:crowdsourcing/widgets/TextFiledHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final int targetId;

  ChatPage(this.targetId);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController textEditingController = new TextEditingController();
  String myId;
  ListNotify<Message> messages = IM.messages;

  listener(){
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messages.addListener(listener);
    IM.onGetHistoryMessages(widget.targetId.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messages.removeListener(listener);
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
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        width: double.infinity,
                        alignment: messages[index].senderUserId != myId
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          child: Text(
                            messages[index].content.conversationDigest(),
                            textAlign: messages[index].senderUserId == myId
                                ? TextAlign.end
                                : TextAlign.start,
                          ),
                          decoration: BoxDecoration(
                              border: Border(),
                              color: messages[index].senderUserId == myId
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 5),
                        ),
                      );
                    })),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withAlpha(180),
            ),
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 25, right: 15, bottom: 8, top: 1),
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(100))))),
                )),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  // padding: const EdgeInsets.only(),
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (textEditingController.text.length == 0) return;
                    IM.sendTextMessage(
                        widget.targetId.toString(), textEditingController.text);
                    textEditingController.clear();
                    setState(() {});
                  },
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
