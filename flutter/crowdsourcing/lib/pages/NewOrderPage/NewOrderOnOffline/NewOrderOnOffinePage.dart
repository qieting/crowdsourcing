import 'package:crowdsourcing/models/UserModel/LocationModel.dart';
import 'package:crowdsourcing/models/object/order/offine/BuyMessage.dart';

import 'package:crowdsourcing/models/object/order/offine/OffineOrder.dart';
import 'package:crowdsourcing/models/object/order/offine/location/Location.dart';
import 'package:crowdsourcing/pages/MyHome/MyHomePage.dart';
import 'package:crowdsourcing/pages/NewOrderPage/NewOrderOnOffline/NewOrderOnOffineSecondPage.dart';
import 'package:crowdsourcing/pages/NewOrderPage/NewOrderStart.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewOrderOnOffline extends StatefulWidget {
  @override
  NewOrderOnOfflineState createState() => NewOrderOnOfflineState();

}

class NewOrderOnOfflineState extends State<NewOrderOnOffline> {
  TextEditingController titleController = new TextEditingController(),
      descriptionController = new TextEditingController(),
      platformController = new TextEditingController(),
      priceController = new TextEditingController(),
      limitController = new TextEditingController();

  List<BuyMessage> buyMessages = [];
  Location to;

  int platform = 1;
  PageController _pageController = new PageController();
  String time = '无限制';

  bool end = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    to = Provider.of<LocationModel>(context, listen: false).getMainLocation();
    if (to == null) {
      to = Location();
    }
  }

  jumpToPage(double nextPage) {
    _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Interval(0, 1, curve: Curves.easeOut));
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
          "发布跑腿悬赏",
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
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("安卓"),
                  value: 2,
                ),
                DropdownMenuItem(
                  child: Text("ios"),
                  value: 3,
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
          NewOrderOnDoofliceSecondPage(
            child: Column(
              children: <Widget>[
                Container(
//          height: 35,
                    decoration: BoxDecoration(color: Colors.white),
                    padding: const EdgeInsets.only(left: 10, right: 15),
                    margin: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Row(
                          children: <Widget>[
                            Flexible(
                              child: RadioListTile<String>(
                                value: "不需要当面提交",
                                title: Text(
                                  '不需要当面提交',
                                  style: TextStyle(fontSize: 14),
                                ),
                                groupValue: end ? "就近购买" : "不需要当面提交",
                                onChanged: (value) {
                                  end = !end;
                                  setState(() {});
                                },
                              ),
                            ),
                            Flexible(
                              child: RadioListTile(
                                value: "指定地址",
                                title: Text('指定地址',
                                    style: TextStyle(fontSize: 14)),
                                groupValue: end ? "指定地址" : "无",
                                onChanged: (value) {
                                  end = !end;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        )),
                      ],
                    )),
                end
                    ? Card(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 0, top: 5, bottom: 15),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(children: <Widget>[
                                  to.province == null
                                      ? Text("设置目的地")
                                      : Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Text(to.name),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Text(
                                              to.phone,
                                            ),
                                          ],
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(to.locationToString()),
                                ]),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: Icon(Icons.chevron_right),
                                onTap: () {
                                  Routers.push(context, Routers.LOCATIONPAGE,
                                      params: {
                                        "location": (location) {
                                          to = location;
                                          setState(() {});
                                        }
                                      });
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 15,
                      )
              ],
            ),
            bugMessages: buyMessages,
            to: to,
            commit: () {
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

              OffineOrder offineOrder = OffineOrder(
                  title: title,
                  describe: des,
                  platFormLimit: platform,
                  limitedTime: time,
                  buyMessages: buyMessages,
                  end: end ? to : null,
                  price: double.parse(price),
                  require: limit);
              Routers.push(context, Routers.ORDEROFFINEDETAILPAGE, params: {
                "offineOrder": offineOrder,
                'success': () {
                  Navigator.of(context).pop();
                  MyHomePage.of().push(Routers.ORDEROFFINEDETAILPAGE,
                      params: {"offineOrder": offineOrder, 'detail': true});
                }
              });
            },
          )
        ],
      ),
    );
  }
}
