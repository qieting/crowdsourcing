import 'package:crowdsourcing/common/IM.dart';
import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:crowdsourcing/pages/FindPage/FindPage.dart';
import 'package:crowdsourcing/pages/Ipage/IPage.dart';
import 'package:crowdsourcing/pages/MenoyPage/MeonyPage.dart';
import 'package:crowdsourcing/pages/MessagePage/MessagePage.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:crowdsourcing/widgets/ChooseOrder/ChooseOrder.dart';
import 'package:crowdsourcing/widgets/HeadWidget/HeadWidget.dart';
import 'package:flutter/material.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';

class MyHomePage extends StatefulWidget {
  static MyHomePageState myHomePageState;

  @override
  MyHomePageState createState() {
    myHomePageState = MyHomePageState();
    return myHomePageState;
  }

  static MyHomePageState of() {
    return myHomePageState;
  }
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller,用来记录顶部tab变化
  //不同接单种类
  List tabs = ["网络", "实地"];

  //当前底部tab选项
  int _selectedIndex = 1;
  Color disableColor, selectedColor;
  PageController pageController =new PageController();

  //相关page
  List<Widget> pages;

  //记录尺寸
  Size size;
  bool choose = false;

  void _onItemTapped(int index) {
    if(index==_selectedIndex){
      return ;
    }
    _selectedIndex = index;
    pageController.jumpToPage(index-1);
    setState(() {
    });

  }

  push(String url, {Map params}) {
    Routers.push(context, url, params: params);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      (pages[0] as MoneyPage).changeTab(_tabController.index);
    });
    if (pages == null) {
      pages = [MoneyPage(), FindPage(), MessagePage(), IPage()];
    }
//    size = MediaQuery.of(context).size;
//    disableColor =Theme.of(context).disabledColor;
//    selectedColor = Theme.of(context).primaryColor;
//    print(disableColor.toString());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    IM.init(context);
    disableColor = Theme.of(context).disabledColor;
    selectedColor = Theme.of(context).primaryColor;
  }

  void changeChoose() {
    choose = !choose;
    setState(() {});
  }

  getTab() {
    switch (_selectedIndex) {
      case 1:
        return TabBar(
            //isScrollable: true,
            indicatorPadding: const EdgeInsets.all(2),
            controller: _tabController,
            tabs: tabs.map((e) => Tab(child: Text(e))).toList());
        break;
      case 4:
        return HeadWidget();
        break;
      default:
        return null;
        break;
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(
                DemoLocalizations.of(context).mainTitle(_selectedIndex - 1)),
            centerTitle: true,
            bottom: getTab()),
        body: Builder(builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // 触摸收起键盘
                if (choose) {
                  changeChoose();
                }
                // FocusScope.of(context).requestFocus(FocusNode());
              },
              child: PageView(
                controller: pageController ,
                children: pages,
                onPageChanged: (index){
                  _selectedIndex=index+1;
                  setState(() {
                  });
                },
              ));
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //
        floatingActionButton: FloatingActionButton(
            //悬浮按钮
            //mini: true,
            //materialTapTargetSize:MaterialTapTargetSize.shrinkWrap
            //tooltip: "ads",
            child: ChooseOrder(choose),
            onPressed: changeChoose),
        bottomNavigationBar: BottomAppBar(
//          color: Colors.white,
          shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _onItemTapped(1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 13, right: 13, bottom: 6, top: 9),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.attach_money,
                          size: 30,
                          color:
                              _selectedIndex == 1 ? selectedColor : disableColor,
                        ),
                        Text(
                          DemoLocalizations.of(context).mainTitle(0),
                          textScaleFactor: 0.6,
                          style: TextStyle(
                            color: _selectedIndex == 1
                                ? selectedColor
                                : disableColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
//              GestureDetector(
//                behavior: HitTestBehavior.translucent,
//                onTap: () {
//                  _onItemTapped(2);
//                },
//                child: Padding(
//                  padding: const EdgeInsets.only(
//                      left: 13, right: 13, bottom: 6, top: 9),
//                  child: Column(
//                    mainAxisSize: MainAxisSize.min,
//                    children: <Widget>[
//                      Icon(
//                        Icons.find_replace,
//                        size: 30,
//                        color:
//                            _selectedIndex == 2 ? selectedColor : disableColor,
//                      ),
//                      Text(
//                        DemoLocalizations.of(context).mainTitle(1),
//                        textScaleFactor: 0.6,
//                        style: TextStyle(
//                          color: _selectedIndex == 2
//                              ? selectedColor
//                              : disableColor,
//                        ),
//                      )
//                    ],
//                  ),
//                ),
//              ),
              SizedBox(
                width: 45,
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _onItemTapped(3);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 13, right: 13, bottom: 6, top: 9),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.message,
                          size: 30,
                          color:
                              _selectedIndex == 3 ? selectedColor : disableColor,
                        ),
                        Text(
                          DemoLocalizations.of(context).mainTitle(2),
                          textScaleFactor: 0.6,
                          style: TextStyle(
                            color: _selectedIndex == 3
                                ? selectedColor
                                : disableColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _onItemTapped(4);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 13, right: 13, bottom: 6, top: 9),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.perm_identity,
                          size: 30,
                          color:
                              _selectedIndex == 4 ? selectedColor : disableColor,
                        ),
                        Text(
                          DemoLocalizations.of(context).mainTitle(3),
                          textScaleFactor: 0.6,
                          style: TextStyle(
                            color: _selectedIndex == 4
                                ? selectedColor
                                : disableColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //中间位置空出
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
          ),
        ));
  }
}
