import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhiteblockWidget extends StatelessWidget {
  WhiteblockWidget(
      {this.title = "管理收货地址",
      this.icon,
      this.onClick,
      this.height = 50,
      this.margin = const EdgeInsets.only(top: 15, bottom: 15)});

  final Function onClick;
  final String title;
  final Widget icon;

  final double height;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15, right: 0),
      margin: margin,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor != Colors.grey[100]
              ? null
              : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: GestureDetector(
        onTap: onClick,
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: <Widget>[
            icon,
            SizedBox(
              width: 10,
            ),
            Text(title),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Icon(
              Icons.keyboard_arrow_right,
            ),
          ],
        ),
      ),
    );
  }
}
