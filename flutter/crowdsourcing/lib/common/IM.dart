import 'package:crowdsourcing/common/ListNotify.dart';
import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:provider/provider.dart';

//即时通讯类
class IM {
  //存储会话列表
  static ListNotify<Conversation> conversationList = ListNotify();
  static bool _init = false;
  static ListNotify<Message> messages = ListNotify();
  static String myTargetId;

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

  static Future<ListNotify<Conversation>> onGetConversationList() async {
    print("获取会话");
    List a = await RongcloudImPlugin.getConversationList([
      RCConversationType.Private,
      RCConversationType.Group,
      RCConversationType.System
    ]);
    conversationList.clear();
    a?.forEach((it) {
      if (it is Conversation) {
        conversationList.add(it);
      }
    });
    return conversationList;
  }

  //当接到离线订单时，给订单单主发送一个消息，我接单了
  static sendOffineOrderMessage(String targetId, String text) async {
    sendTextMessage(targetId, text);
  }

  //向数据库插入发出的消息，这个是在你没有发出时候插入，在你发出消息后，默认是自动插入的
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

  //获取与某人的最近历史消息,在这里我们做了替换，让message变为static
  static Future<ListNotify<Message>> onGetHistoryMessages(String targetId,
      {int start = 0, int end = 10}) async {
    List msgs = await RongcloudImPlugin.getHistoryMessage(
        RCConversationType.Private, targetId, start, end);
    if (targetId != myTargetId) {
      messages.clear();
      msgs = msgs.reversed.toList();
      msgs.forEach((it) {
        if (it is Message) {
          messages.add(it);
        }
      });
      myTargetId = targetId;
    } else {
      messages.clear();
      msgs = msgs.reversed.toList();
      msgs.forEach((it) {
        if (it is Message) {
          messages.add(it);
        }
      });
    }
    return messages;
  }

  //发送文字个人消息
  static sendTextMessage(String targetId, String text) async {
    TextMessage txtMessage = TextMessage.obtain(text);
    Message msg = await RongcloudImPlugin.sendMessage(
        RCConversationType.Private, targetId + "", txtMessage);
    print("send message start senderUserId = " + msg.senderUserId);
    if (targetId == myTargetId) {
      messages.add(msg);
    }
  }
}
