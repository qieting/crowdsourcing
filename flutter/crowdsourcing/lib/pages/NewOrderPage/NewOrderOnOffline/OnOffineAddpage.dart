import 'package:crowdsourcing/channel/BaiduChannel.dart';
import 'package:crowdsourcing/models/object/BuyMessage.dart';
import 'package:crowdsourcing/models/object/Location.dart';
import 'package:crowdsourcing/models/object/MyPoi.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:crowdsourcing/widgets/TextFiledHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnOfficeAddpage extends StatefulWidget {
  @override
  _OnOffineAddpageState createState() => _OnOffineAddpageState();
}

class _OnOffineAddpageState extends State<OnOfficeAddpage> {
  bool jiujin = true;
  Location location = new Location();
  TextEditingController thingsController = new TextEditingController(),
      priceController = new TextEditingController(),
      disController = new TextEditingController(),
      phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "设置代拿代取地",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[100]),
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("请输入想要购买/代拿的物品"),
              Container(
//          height: 35,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.only(left: 10, right: 15),
                  margin: const EdgeInsets.only(top: 4),
                  child: TextField(
                    controller: thingsController,
                      maxLines: 3,
                      decoration: MyDecoration.copyBorder(InputDecoration(
                        isDense: false,
                        border: InputBorder.none,
                      )))),
              Container(
//          height: 35,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.only(left: 10, right: 15),
                  margin: const EdgeInsets.only(top: 15),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text("预估价格")),
                      Container(
                        width: 100,
                        child: TextField(
                            textAlign: TextAlign.end,
                            keyboardType: TextInputType.number,
                            controller: priceController,
                            inputFormatters: [
                              WhitelistingTextInputFormatter(RegExp("[0-9]")),
                              LengthLimitingTextInputFormatter(5)
                            ],
                            decoration: MyDecoration.copyBorder(
                              InputDecoration(
                                  isDense: false, border: InputBorder.none),
                            )),
                      ),
                      Text("元")
                    ],
                  )),
              Container(
//          height: 35,
                decoration: BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.only(left: 10, right: 15),
                margin: const EdgeInsets.only(top: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("描述"),
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                          maxLengthEnforced: true,
                          textAlign: TextAlign.end,
                          maxLines: 3,
                          style: TextStyle(fontSize: 15),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(40)
                          ],
                          decoration: InputDecoration(
                            //decoration设置后让textfiled有了默认最小尺寸，因此我们设置
                            //isdence让该限制取消
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(left: 15, top: 10, bottom: 10),
                            hintText: "最长40字,可为空",
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                          )),
                    )
                  ],
                ),
              ),
              Container(
//          height: 35,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.only(left: 10, right: 15),
                  margin: const EdgeInsets.only(top: 15),
                  child: Row(
                    children: <Widget>[
                      Text("联系方式(选填)"),
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: TextField(
                            textAlign: TextAlign.end,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              WhitelistingTextInputFormatter(RegExp('[0-9]')),
                              LengthLimitingTextInputFormatter(11)
                            ],
                            decoration: MyDecoration.copyBorder(
                              InputDecoration(
                                  hintText: "如需要联系对方请填写",
                                  isDense: false,
                                  border: InputBorder.none),
                            )),
                      ),
                    ],
                  )),
              Container(
//          height: 35,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.only(left: 10, right: 15),
                  margin: const EdgeInsets.only(top: 15),
                  child: Row(
                    children: <Widget>[
                      Text("购买地址"),
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Flexible(
                            child: RadioListTile<String>(
                              value: "就近购买",
                              title: Text(
                                '就近购买',
                                style: TextStyle(fontSize: 14),
                              ),
                              groupValue: jiujin ? "就近购买" : "指定地址",
                              onChanged: (value) {
                                jiujin = !jiujin;
                                setState(() {});
                              },
                            ),
                          ),
                          Flexible(
                            child: RadioListTile(
                              value: "指定地址",
                              title:
                                  Text('指定地址', style: TextStyle(fontSize: 14)),
                              groupValue: jiujin ? "就近购买" : "指定地址",
                              onChanged: (value) {
                                jiujin = !jiujin;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      )),
                    ],
                  )),
              !jiujin
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Divider(
                          height: 1,
                        ),
                        Container(
                          height: 45,
                          width: double.infinity,
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(color: Colors.white),
                          padding: const EdgeInsets.only(left: 10, right: 15),
                          child: GestureDetector(
                              onTap: () {
                                BaiduChannel.getLocation(
                                    (Location _location) async {
                                  if (_location.city != null) {
                                    location = await Routers.pushForResult(
                                        context, Routers.POIPAGE,
                                        params: {'city': _location.city})??location;
                                    setState(() {});
                                  }
                                });
                              },
                              child: location.name == null
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text("查找地址"),
                                        Icon(Icons.chevron_right)
                                      ],
                                    )
                                  : Text(
                                      location.name,
                                      textAlign: TextAlign.end,
                                    )),
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    )
                  : SizedBox(
                      height: 25,
                    ),
            ],
          ),
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

            SizedBox(
              width: 10,
            ),
            FlatButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              shape: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(35))),
              child: Text("提交订单"),
              onPressed: () {
                BuyMessage buyMessage = new BuyMessage();
                String goods =thingsController.text;
                if(goods.length>0){
                  buyMessage.goods=goods;
                }else{
                  MyToast.toast("物品不能为空");
                  return ;
                }

                String price = priceController.text;
                if (price.length > 0 && double.parse(price) != 0) {
                  buyMessage.price=double.parse(price);
                }else{
                  MyToast.toast("预估价格必须填写");
                  return;
                }
                String describe =disController.text;
                buyMessage.describe=describe;

                String phone = phoneController.text;
                if (phone.length == 11) {
                  location.phone = phone;
                } else if (phone.length != 0) {
                  MyToast.toast("请输入正确的手机号");
                }

                if(!jiujin&&location.name==null){
                  MyToast.toast("请选择位置或者设置就近购买");
                  return ;
                }
                buyMessage.location=location;
                Navigator.of(context).pop<BuyMessage>(buyMessage);

              },
            )
          ],
        ),
      ),
    );
  }
}
