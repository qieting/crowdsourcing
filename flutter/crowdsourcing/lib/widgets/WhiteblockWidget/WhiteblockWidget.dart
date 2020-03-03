
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhiteblockWidget extends StatelessWidget {

  WhiteblockWidget({this.title="管理收货地址",this.icon,this.onClick,this.height=35,this.margin =const EdgeInsets.only(top: 15,bottom: 15)});

  final Function onClick;
  final String title;
  final Widget icon ;
  final double height;
  final EdgeInsets margin;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      margin: margin,
      child: Row(
         children: <Widget>[
           icon,
           Text(title),
           Expanded(
             flex: 1,
             child: SizedBox(),
           )

         ],
      ),

    );
  }
}

