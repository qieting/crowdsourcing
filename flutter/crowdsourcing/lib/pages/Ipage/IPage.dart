



import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:flutter/cupertino.dart';

class IPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IState();
  }

}

class IState extends State<IPage>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(

      children: <Widget>[
        Text(DemoLocalizations.of(context).mainTitle(4)+"dasdihqsahduiashgfasjbfhjsabfhjasfbhasbfas"),
      ],
    );  }

}