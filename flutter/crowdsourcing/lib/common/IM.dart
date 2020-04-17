import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:provider/provider.dart';

//即时通讯类
class IM {
  //存储会话列表
  static List<Conversation> conversationList;
  static bool _init =false;
  //初始化Im
  static init(context) async {
    if(!_init) {
      _init=true;
      RongcloudImPlugin.init("3argexb63s7he");
      onGetConversationList();
      //连接服务器，通过id作为token
      int rc = await RongcloudImPlugin.connect(Provider
          .of<UserModel>(context)
          .user
          .token);
      print("连接参数$rc");
      RongcloudImPlugin.onMessageReceived = (Message msg, int left) {
        for (var conversation in conversationList) {
          if (msg.senderUserId == conversation.senderUserId) {
            conversation.latestMessageId = msg.messageId;
            conversation.latestMessageContent = msg.content;
            return;
          }
          onGetConversationList();
        }
        print(
            "receive message messsageId:" + msg.messageId.toString() +
                " left:" +
                left.toString());
      };

      //消息发送结果回调,30代表发送成功
      RongcloudImPlugin.onMessageSend = (int messageId, int status, int code) {
        print("send message messsageId:" + messageId.toString() + " status:" +
            status.toString() + " code:" + code.toString());
      };
    }
  }

  static Future<List> onGetConversationList() async {
    if (conversationList == null) {
      List a = await RongcloudImPlugin.getConversationList([
        RCConversationType.Private,
        RCConversationType.Group,
        RCConversationType.System
      ]);
conversationList =    a?.map<Conversation>((it){return (it as Conversation);})?.toList();
    }
    return conversationList;
  }

  //当接到离线订单时，给订单单主发送一个消息，我接单了
  static sendOffineOrderMessage(String targetId) async {
    TextMessage txtMessage = new TextMessage();
    txtMessage.content = "我接单了";
    Message msg = await RongcloudImPlugin.sendMessage(
        RCConversationType.Private, targetId + "", txtMessage);
    print("send message start senderUserId = " + msg.senderUserId);
  }
}