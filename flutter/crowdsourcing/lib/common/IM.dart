import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:provider/provider.dart';

//即时通讯类
class IM {
  //存储会话列表
  static List<Conversation> conversationList =[];
  static bool _init = false;

  //初始化Im
  static init(context) async {
    if (!_init) {
      _init = true;
      RongcloudImPlugin.init("3argexb63s7he");

      //连接服务器，通过id作为token
      int rc = await RongcloudImPlugin.connect(
          Provider.of<UserModel>(context).user.token);
      onGetConversationList();
      print("连接参数$rc");
      RongcloudImPlugin.onMessageReceived = (Message msg, int left) {
        RongcloudImPlugin.insertIncomingMessage(
            msg.conversationType,
            msg.targetId,
            msg.senderUserId,
            0,
            msg.content,
            msg.sentTime, (msg, code) {
          print("insertIncomingMessage " +
              msg.content.encode() +
              " code " +
              code.toString());
        });
        print("receive message messsageId:" +
            msg.messageId.toString() +
            " left:" +
            left.toString());
        onGetConversationList();
      };

      //消息发送结果回调,30代表发送成功
      RongcloudImPlugin.onMessageSend = (int messageId, int status, int code) {
        onGetConversationList();
        print("send message messsageId:" +
            messageId.toString() +
            " status:" +
            status.toString() +
            " code:" +
            code.toString());
      };
    }
  }

  static Future<List> onGetConversationList() async {
    print("获取会话");
    List a = await RongcloudImPlugin.getConversationList([
      RCConversationType.Private,
      RCConversationType.Group,
      RCConversationType.System
    ]);
    conversationList.clear();
    a?.forEach((it) {
      if(it is Conversation){
        if(!conversationList.contains(it)){
          conversationList.add(it);
        }
      }
    });

    return conversationList;
  }

  //当接到离线订单时，给订单单主发送一个消息，我接单了
  static sendOffineOrderMessage(String targetId,String text) async {
    sendTextMessage(targetId, text);
  }

  static insertOutgoingMessage(Message msg) {
    RongcloudImPlugin.insertOutgoingMessage(
        msg.conversationType, msg.targetId, 30, msg.content, msg.sentTime,
        (msg, code) {
      print("insertOutgoingMessage " +
          msg.content.encode() +
          " code " +
          code.toString());
    });
  }

  //获取与某人的最近历史消息
  static Future<List<Message>> onGetHistoryMessages(String targetId) async {
    List msgs = await RongcloudImPlugin.getHistoryMessage(
        RCConversationType.Private, targetId, 0, 10);
    print("get history message");
    return (msgs?.map<Message>((it) {
          return (it as Message);
        })?.toList()) ??
        [];
  }

  //发送文字个人消息
  static sendTextMessage(String targetId, String text) async {
    TextMessage txtMessage = TextMessage.obtain(text);
    Message msg = await RongcloudImPlugin.sendMessage(
        RCConversationType.Private, targetId + "", txtMessage);
    print("send message start senderUserId = " + msg.senderUserId);
  }
}
