import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:crowdsourcing/widgets/WhiteblockWidget/WhiteblockWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
