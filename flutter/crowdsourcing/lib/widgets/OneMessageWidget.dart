import 'package:data_plugin/bmob/realtime/change.dart';
import 'package:flutter/material.dart';

//用于展示个人信息的某一项
class OneMessageWidget extends StatelessWidget {
  final String title;
  final Widget content;
  final Function change;

  OneMessageWidget({@required this.title, @required this.content, this.change});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: 55.0 //最小高度为50像素
            ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(left: 15, right: 10),
          child: Row(
            children: <Widget>[
              Text(title),
              Expanded(
                child: SizedBox(),
              ),
              GestureDetector(
                onTap: change,
                child: Row(
                  children: <Widget>[
                    content,
                    change != null
                        ? Icon(Icons.chevron_right,color: Colors.grey[400],)
                        : SizedBox(
                            width: 1,
                          )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
