import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:flutter/cupertino.dart';

class MoneyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MoneyPageState();
  }
}

class MoneyPageState extends State<MoneyPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(DemoLocalizations.of(context).mainTitle(1));
  }
}
