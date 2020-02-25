



import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:data_plugin/bmob/realtime/message.dart';
import 'package:data_plugin/bmob/realtime/message.dart';
import 'package:data_plugin/bmob/realtime/message.dart';
import 'package:flutter/cupertino.dart';

class MessagePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MessagePageState();
  }

}

class MessagePageState extends State<MessagePage>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(DemoLocalizations.of(context).mainTitle(2));  }

}