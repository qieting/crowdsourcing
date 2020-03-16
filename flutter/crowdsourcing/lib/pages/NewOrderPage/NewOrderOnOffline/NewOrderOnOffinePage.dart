import 'package:crowdsourcing/models/UserModel/LocationModel.dart';
import 'package:crowdsourcing/models/object/Location.dart';
import 'package:crowdsourcing/pages/NewOrderPage/NewOrderOnOffline/NewOrderOnOffineSecondPage.dart';
import 'package:crowdsourcing/pages/NewOrderPage/NewOrderStart.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewOrderOnOffline extends StatefulWidget {
  @override
  NewOrderOnOfflineState createState() => NewOrderOnOfflineState();

  static NewOrderOnOfflineState of(BuildContext context) {
    return context.findAncestorStateOfType<NewOrderOnOfflineState>();
  }
}

class NewOrderOnOfflineState extends State<NewOrderOnOffline> {
  TextEditingController titleController = new TextEditingController(),
      descriptionController = new TextEditingController(),
      platformController = new TextEditingController(),
      limitController = new TextEditingController(),
      mobileController = new TextEditingController();

  List locations = [];
  Location to;

  int platform = 1;
  PageController _pageController = new PageController();

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
            titleController: titleController,
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
          ),
          NewOrderOnDoofliceSecondPage(
              locations: locations,
              to: to,
              setTo: () async {
                Routers.push(context, Routers.LOCATIONPAGE, params: {
                  "location": (location) {
                    to = location;
                    setState(() {});
                  }
                });
              }),
          Text(58.toString())
        ],
      ),
    );
  }
}
