import 'package:crowdsourcing/models/OrderModel/OffineOrderModel.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:crowdsourcing/widgets/WhiteblockWidget/WhiteblockWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IState();
  }
}

class IState extends State<IPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(child: Consumer<OffineOrderingModel>(
            builder: (context, offineOrderings, child) {
          return Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
              child: Card(
                  child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text("a"),
                            decoration: BoxDecoration(
                              color: Colors.red
                            ),
                            height: double.infinity,
                            alignment:Alignment.center,
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                child: Text("a"),
                              )
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text("a"),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text("a"),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )));
        })),
        WhiteblockWidget(
          icon: Icon(
            Icons.location_city,
            color: Theme.of(context).accentColor.withAlpha(180),
          ),
          onClick: () {
            Routers.push(context, Routers.LOCATIONPAGE);
          },
        )
      ],
    );
  }
}
