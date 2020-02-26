import 'package:flutter/material.dart';

class NewOrderOnOffline extends StatefulWidget {
  @override
  _NewOrderOnOfflineState createState() => _NewOrderOnOfflineState();
}

class _NewOrderOnOfflineState extends State<NewOrderOnOffline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back),onPressed: (){
          Navigator.of(context).pop();
        },),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("发布跑腿悬赏",style: TextStyle(fontSize: 20),), centerTitle: true,
      ),
      body: PageView(
        children: <Widget>[
          Container(

          ),
          Text(58.toString()),
          Text(58.toString())
        ],
      ),
    );
  }
}
