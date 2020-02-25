import 'package:crowdsourcing/pages/MyHome/MyHomePage.dart';
import 'package:flutter/material.dart';

import 'ChooseOverLay.dart';

class ChooseOrder extends StatefulWidget {
  ChooseOrder(this.choose);

  final bool choose;

  @override
  _ChooseOrderState createState() => _ChooseOrderState();
}

class _ChooseOrderState extends State<ChooseOrder>
    with SingleTickerProviderStateMixin {
  Animation<double> turnAnimation;
  Animation<double> sizeAnimation;
  AnimationController controller;
  ChooseOverLay chooseOverLay;
  FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    turnAnimation = new Tween(begin: 0.0, end: 0.125)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    sizeAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    chooseOverLay = ChooseOverLay(context, sizeAnimation, controller);

  }

  

  @override
  Widget build(BuildContext context) {
    return ChooseOrderWidget(
      controller: controller,
      animations: [turnAnimation, sizeAnimation],
    );
  }

  @override
  void didUpdateWidget(ChooseOrder oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
//    if(sizeAnimation.value==0){
//      Future.delayed(Duration(milliseconds: 200)).then((e) {
//        setState(() {
//          chooseOverLay.show();
//        });
//      });
//
//    }
    if (oldWidget.choose != widget.choose) {
      controller.stop();
      if (widget.choose) {
        controller.forward();
      } else {
        controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
}

//采用AnimatedWidget组件为了避免addlistener外加state的繁琐操作
class ChooseOrderWidget extends AnimatedWidget {
  AnimationController controller;
  List animations;

  ChooseOrderWidget({
    this.animations,
    this.controller,
  }) : super(listenable: controller);

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RotationTransition(
            turns: animations[0],
            child: Icon(
              Icons.add,
              size: 30,
            )),
      ],
    );
  }
}
