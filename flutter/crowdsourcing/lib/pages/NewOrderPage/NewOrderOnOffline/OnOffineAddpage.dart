import 'package:flutter/material.dart';

class OnOfficeAddpage extends StatefulWidget {
  @override
  _OnOffineAddpageState createState() => _OnOffineAddpageState();
}

class _OnOffineAddpageState extends State<OnOfficeAddpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "设置代拿代取地",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[200]),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            RaisedButton.icon(
              icon: Icon(Icons.location_on),
              label: Text("点击选择送达位置"),
            ),
            Text("请输入"),
            TextField(),
            TextField(),
            TextField(),
            RaisedButton.icon(
              icon: Icon(Icons.location_on),
              label: Text("点击选择送达位置"),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(right: 15),
        height: 55,
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text("共0件,",style: TextStyle(fontSize:14,color:Colors.grey[700]),),
            Text("合计:"),
            SizedBox(width: 3,),
            Text("0.00",style: TextStyle(fontSize: 20,color:Colors.amberAccent[700]),),
            SizedBox(width: 10,),
            FlatButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(35))
              ),
              child: Text("提交订单"),
              onPressed: (){},
            )
          ],
        ),
      ),
    );
  }
}
