import 'package:crowdsourcing/common/ListNotify.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Toast 显示位置控制
enum ToastPostion {
  top,
  center,
  bottom,
}

//var _list = new ListNotify();
class MyToast {
  //这个overlay是在matericalAPP内加的一层，类似于stack
  static OverlayState _overlayState;
  static var _list = new ListNotify();

  //在覆层上的插入物
  static OverlayEntry _entry;
  static bool _show = false;

  static init(BuildContext context) {
    //在这里我们的初始化选择保留overlaystate，而不是相应的context
    //因为这里涉及到保留的context的问题，因为这个overlay是在matericalAPP下
    //所以我们不能使用matericalAPP的context，如果我们选择某一个界面的context，又有可能会被销毁
    //而我们直接选择获取到相应的overlay，这个是唯一且不会被销毁的
    _overlayState = Overlay.of(context);
    _list.addListener(() {
      if (_list.length == 0) {
        _entry.remove();
        _show = false;
      } else {
        if (!_show) {
          _show = true;
          __showToast();
        } else {
          _entry.remove();
          __showToast();
        }
      }
    });
  }

  static toast(String content,
      {int millisecond = 2000, ToastPostion position = ToastPostion.bottom}) {
    var t = ToastSave(content, position);
    _list.add(t);
    //定时删除
    Future.delayed(new Duration(milliseconds: millisecond), () {
      _list.remove(t);
    });
  }

  static __showToast() {
    if (_overlayState == null) {
      throw new Exception("context没有正常初始化");
    }
    _entry = new OverlayEntry(builder: _builderToast);
    _overlayState.insert(_entry);
  }

  static Widget _builderToast(context) {
    //考虑到长toast，因此最小显示3行的大小
    int i = _list.length > 3 ? _list.length : 3;
    return Positioned(
      top: MediaQuery.of(context).size.height - 150 - i * 15,
      bottom: 150.0 - i * 15,
      left: 25,
      right: 25,
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[100].withAlpha(0)),
//        padding: EdgeInsets.all(0),
//        margin: EdgeInsets.all(0),
        alignment: Alignment.center,
        //listview顶部默认会有一定大小的padding，因此这里取消
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
              itemCount: _list.length,
              //itemExtent: 30.0, //强制高度为50.0
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Text(
                    _list.get(index).content,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      color: Colors.grey[700],
                    ),
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
