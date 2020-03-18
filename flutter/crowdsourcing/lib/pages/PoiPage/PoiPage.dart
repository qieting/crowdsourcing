import 'package:crowdsourcing/channel/BaiduChannel.dart';
import 'package:crowdsourcing/models/object/MyPoi.dart';
import 'package:crowdsourcing/widgets/TextFiledHelper.dart';
import 'package:flutter/material.dart';

class PoiPage extends StatefulWidget {
  PoiPage({@required this.city});

  final String city;

  @override
  _PoiPageState createState() => _PoiPageState();
}

class _PoiPageState extends State<PoiPage> {
  TextEditingController textEditingController = new TextEditingController();
  List<MyPoi> pois = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
                child: TextField(
                    autofocus: true,
                    controller: textEditingController,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    cursorColor: Colors.white,
                    cursorWidth: 1,
                    decoration: MyDecoration.copyBorder(InputDecoration(
                        isDense: true,
                        hintStyle: TextStyle(
                            color: Colors.white.withAlpha(100), fontSize: 13),
                        hintText: "请输入位置",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(35))))))),
            FlatButton(
              child: Text(
                '查找',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                String keyWord = textEditingController.text;
                BaiduChannel.getPois(widget.city, keyWord, (List<MyPoi> pois) {
                  this.pois = pois;
                  setState(() {});
                });
              },
            )
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        child: ListView.builder(
            itemCount: pois.length,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      pois[index].name,
                      textScaleFactor: 1.2,
                    ),
                    SizedBox(height: 3,),
                    Text(
                      pois[index].address,
                      textScaleFactor: 0.8,
                      style: TextStyle(color: Colors.grey[500]),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
