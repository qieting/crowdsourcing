import 'package:crowdsourcing/models/object/order/offine/BuyMessage.dart';
import 'package:crowdsourcing/models/object/order/offine/location/Location.dart';
import 'package:crowdsourcing/pages/NewOrderPage/NewOrderOnOffline/NewOrderOnOffinePage.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewOrderOnDoofliceSecondPage extends StatelessWidget {
  NewOrderOnDoofliceSecondPage(
      {@required this.bugMessages,
      @required this.to,
        this.child,
      @required this.commit});

  final List<BuyMessage> bugMessages;
  final Location to;
  final Function commit;
  final Widget child;
  bool end =true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FlatButton.icon(
                      shape: OutlineInputBorder(borderSide: BorderSide.none),
                      onPressed: () async {
                        BuyMessage bu = await Routers.pushForResult<BuyMessage>(
                            context, Routers.OnOfficeAdd);
                        if (bu!=null&&bu.goods != null) bugMessages.add(bu);
                      },
                      icon: Icon(Icons.add),
                      label: Text("增加代拿代买地")),
                  ListView.builder(
                      itemCount: bugMessages.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Container(
                            padding: const EdgeInsets.only(left: 15, top: 15),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(bugMessages[index].goods),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(bugMessages[index].location.name ??
                                          "就近购买")
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {},
                                )
                              ],
                            ),
                          ),
                        );
                        ;
                      }),
                  Divider(),
                  Text("目的地"),
                  child,

                ],
              ),
            ),
          ),
          Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 40),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide.none),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "预览",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      commit();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
