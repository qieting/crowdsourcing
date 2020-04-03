import 'package:crowdsourcing/models/object/order/offine/OffineOrdering.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:flutter/material.dart';

class OffineOrderingPage extends StatefulWidget {
  final int orderId;

  OffineOrderingPage(this.orderId);

  @override
  _OffineOrderingPageState createState() => _OffineOrderingPageState();
}

class _OffineOrderingPageState extends State<OffineOrderingPage> {


  Future<OffineOrdering> getOffineOrderingByOrderId()async{
     return  await MyDio.getOffineOrderingByOrderId(context, widget.orderId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("订单详情（线下"),),
      body:FutureBuilder<OffineOrdering>(
        future: getOffineOrderingByOrderId(),
        builder: (context,AsyncSnapshot<OffingOrdering>){

      },
      ) ,
    );
  }
}
