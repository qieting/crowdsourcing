import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:flutter/cupertino.dart';

class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FindPageState();
  }
}

class FindPageState extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(DemoLocalizations.of(context).mainTitle(2));
  }
}
