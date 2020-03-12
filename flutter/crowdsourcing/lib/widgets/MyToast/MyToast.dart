import 'package:crowdsourcing/widgets/MyToast/ListNotify.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Toast 显示位置控制
enum ToastPostion {
  top,
  center,
  bottom,
}

//var list = new ListNotify();
class MyToast {
  //这个overlay是在matericalAPP内加的一层，类似于stack
  static OverlayState overlayState;
  static var list = new ListNotify();

  //在覆层上的插入物
  static OverlayEntry entry;
  static bool show = false;

  static init(BuildContext context) {
    //在这里我们的初始化选择保留overlaystate，而不是相应的context
    //因为这里涉及到保留的context的问题，因为这个overlay是在matericalAPP下
    //所以我们不能使用matericalAPP的context，如果我们选择某一个界面的context，又有可能会被销毁
    //而我们直接选择获取到相应的overlay，这个是唯一且不会被销毁的
    overlayState = Overlay.of(context);
    list.addListener(() {
      if (list.length == 0) {
        entry.remove();
        show = false;
      } else {
        if (!show) {
          show = true;
          _showToast();
        } else {
          entry.remove();
          _showToast();
        }
      }
    });
  }

  static toast(String content,
      {int millisecond = 2000, ToastPostion position = ToastPostion.bottom}) {
    var t = ToastSave(content, position);
    list.add(t);
    //定时删除
    Future.delayed(new Duration(milliseconds: millisecond), () {
      list.remove(t);
      print("变化" + list.length.toString());
    });
  }

  static _showToast() {
    if (overlayState == null) {
      throw new Exception("context没有正常初始化");
    }
    entry = new OverlayEntry(builder: _builderToast);
    overlayState.insert(entry);
  }

  static Widget _builderToast(context) {
    int i = list.length;
    return Positioned(
      top: MediaQuery.of(context).size.height - 150 - i * 15,
      bottom: 150.0 - i * 15,
      left: 25,
      right: 25,
      child: Container(
        decoration: BoxDecoration(
          color:  Colors.grey[100]
        ),
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(0),
        alignment: Alignment.center,
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
              itemCount: list.length,
              itemExtent: 30.0, //强制高度为50.0
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Text(
                    list.get(index).content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.none,
                        color: Colors.grey[700],),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class ToastSave {
  ToastSave(this.content, this.toastPostion);

  String content;

  ToastPostion toastPostion;
}
