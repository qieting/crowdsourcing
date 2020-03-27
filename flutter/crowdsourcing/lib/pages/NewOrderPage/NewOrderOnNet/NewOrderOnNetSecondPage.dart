import 'package:crowdsourcing/models/object/order/online/OnlineStep.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewOrderOnNetSecondPage extends StatelessWidget {
  NewOrderOnNetSecondPage(this.onlineSteps, this.numberController,this.sunbmit);

  final TextEditingController numberController;
  final List<OnlineStep> onlineSteps;
  final Function sunbmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, top: 15),
      child: Column(
        children: <Widget>[
          Container(
//          height: 35,
            decoration: BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.only(left: 10, right: 15),
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text("接单人数"),
                  padding: EdgeInsets.only(top: 10),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                      maxLengthEnforced: true,
                      textAlign: TextAlign.end,
                      controller: numberController,
                      style: TextStyle(fontSize: 15),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(5),
                        WhitelistingTextInputFormatter(RegExp("[0-9]"))
                      ],
                      decoration: InputDecoration(
                        //decoration设置后让textfiled有了默认最小尺寸，因此我们设置
                        //isdence让该限制取消
                        isDense: true,
                        contentPadding:
                            EdgeInsets.only(left: 15, top: 10, bottom: 10),
                        hintText: "请输入发单数",
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                      )),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.cyanAccent,
                borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(35), left: Radius.circular(5))),
            padding: const EdgeInsets.only(left: 15),
            margin: const EdgeInsets.only(top: 25),
            width: double.infinity,
            height: 40,
            child: GestureDetector(
                child: Row(
              children: <Widget>[
                Text("增加步骤"),
                Expanded(
                  child: SizedBox(),
                ),
                IconButton(
                    onPressed: () async {
                      OnlineStep o = await Routers.pushForResult(
                          context, Routers.ADDONLINEPAGE);
                      if (o != null) {
                        onlineSteps.add(o);
                      }
                    },
                    icon: Icon(Icons.add)),
              ],
            )),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                    decoration: BoxDecoration(
                        color: Colors.primaries[index % 7],
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(35),
                            left: Radius.circular(5))),
                    padding: const EdgeInsets.only(left: 15),
                    width: double.infinity,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                        child: Text(onlineSteps[index].explain)));
              },
              itemCount: onlineSteps.length,
              shrinkWrap: true,
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
                      // jump(1.0);
                      sunbmit();
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
