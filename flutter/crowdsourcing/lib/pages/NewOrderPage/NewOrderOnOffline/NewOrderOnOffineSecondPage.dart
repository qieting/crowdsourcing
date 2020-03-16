import 'package:crowdsourcing/models/object/Location.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:flutter/material.dart';

class NewOrderOnDoofliceSecondPage extends StatelessWidget {
  NewOrderOnDoofliceSecondPage({@required this.locations, @required this.to,@required this.setTo});

  final List locations;
  final Location to;
  final Function setTo ;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlatButton.icon(
              shape: OutlineInputBorder(borderSide: BorderSide.none),
              onPressed: () {
                Routers.push(context, Routers.OnOfficeAdd);
              },
              icon: Icon(Icons.add),
              label: Text("增加代拿代买地")),
          ListView.builder(
              itemCount: locations.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(title: Text("$index"));
                ;
              }),
          Divider(),
          Text("目的地"),
          Card(
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
                     setTo();
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
