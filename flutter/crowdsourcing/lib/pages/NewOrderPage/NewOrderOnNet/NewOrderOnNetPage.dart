import 'package:crowdsourcing/models/object/order/online/OnlineOrder.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineStep.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/pages/MyHome/MyHomePage.dart';
import 'package:crowdsourcing/pages/NewOrderPage/NewOrderOnNet/NewOrderOnNetSecondPage.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:flutter/material.dart';

import '../NewOrderStart.dart';

class NewOrderOnNet extends StatefulWidget {
  @override
  NewOrderOnNetState createState() => NewOrderOnNetState();

  static NewOrderOnNetState of(BuildContext context) {
    return context.findAncestorStateOfType<NewOrderOnNetState>();
  }
}

class NewOrderOnNetState extends State<NewOrderOnNet> {
  int platform = 0;
  PageController _pageController = new PageController();
  String time = '无限制';
  List<OnlineStep> onLineSteps = [];

  TextEditingController titleController = new TextEditingController(),
      descriptionController = new TextEditingController(),
      platformController = new TextEditingController(),
      priceController = new TextEditingController(),
      numberController = new TextEditingController(),
      limitController = new TextEditingController();

  jumpToPage(double nextPage) {
    _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Interval(0, 1, curve: Curves.easeOut));
  }

  submit(){
    String title = titleController.text;
    if (title.length == 0) {
      MyToast.toast("标题不能为空");
      return;
    }
    String des = descriptionController.text;
    if (des.length == 0) {
      MyToast.toast("描述不能为空");
      return;
    }
    String limit = limitController.text;
    if (limit.length == 0) {
      MyToast.toast("报名条件不能为空");
      return;
    }
    String price = priceController.text;
    if (price.length != 0 && double.parse(price) > 0) {
    } else {
      MyToast.toast("请输入价格");
      return;
    }
    String number  =numberController.text;
    if (number.length != 0 && int.parse(number) > 0) {
    } else {
      MyToast.toast("请输入正确的人数");
      return;
    }

    OnlineOrder offineOrder = OnlineOrder(
        title: title,
        describe: des,
        number: int.parse(number),
        platFormLimit: platform,
        limitedTime: time,
        onlineSteps: onLineSteps,
        price: double.parse(price),
        require: limit);

    Routers.push(context, Routers.ORDERONLINEDETAILSPAGE, params: {
      "onlineOrder": offineOrder,
      'success': (_o) {
        Navigator.of(context).pop();
        MyHomePage.of().push(Routers.ORDERONLINEDETAILSPAGE,
            params: {"onlineOrder": _o, 'detail': true});
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          "发布线上悬赏",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          NewOrderStart(
            jump: jumpToPage,
            titleController: titleController,
            priceController: priceController,
            descriptionController: descriptionController,
            platformController: platformController,
            limitController: limitController,
            child: DropdownButton(
              value: platform,
              underline: SizedBox(),
              items: [
                DropdownMenuItem(
                  child: Text("无限制"),
                  value: 0,
                ),
                DropdownMenuItem(
                  child: Text("安卓"),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("ios"),
                  value: 2,
                )
              ],
              onChanged: (value) {
                platform = value;
                setState(() {});
              },
            ),
            child1: DropdownButton(
              selectedItemBuilder: (context) {
                return [Center(child: Text('无限制')), Center(child: Text(time))];
              },
              value: time,
              underline: SizedBox(),
              items: [
                DropdownMenuItem(
                  child: Text("无限制"),
                  value: "无限制",
                ),
                DropdownMenuItem(
                  child: Text(time == "无限制" ? "选择时间" : "重新选择"),
                  value: time == "无限制" ? "a" : time,
                ),
              ],
              onChanged: (value) async {
                if (value == '无限制') {
                  time = "无限制";
                } else {
                  DateTime selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(Duration(days: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 30)),
                    builder: (BuildContext context, Widget child) {
                      return Theme(
                        data: ThemeData.dark(),
                        child: child,
                      );
                    },
                  );
                  if (selectedDate == null) {
                    return;
                  }
                  TimeOfDay selectedTime24Hour = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (BuildContext context, Widget child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child,
                      );
                    },
                  );
                  if (selectedTime24Hour == null) {
                    return;
                  }
                  selectedDate.add(Duration(
                      hours: selectedTime24Hour.hour,
                      minutes: selectedTime24Hour.minute));
                  if (selectedDate.isBefore(DateTime.now())) {
                    MyToast.toast("选择的时间必须在当前时间之后");
                    return;
                  }
                  time = selectedDate.year.toString() +
                      "-" +
                      selectedDate.month.toString() +
                      "-" +
                      selectedDate.day.toString() +
                      "-" +
                      selectedTime24Hour.hour.toString() +
                      "-" +
                      selectedTime24Hour.minute.toString();
                }

                setState(() {});
              },
            ),
          ),
          NewOrderOnNetSecondPage(onLineSteps,numberController,submit)
        ],
      ),
    );
  }
}
