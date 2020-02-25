import 'dart:ffi';

import 'package:crowdsourcing/pages/MyHome/MyHomePage.dart';
import 'package:crowdsourcing/pages/MyHome/MyHomePage.dart';
import 'package:flutter/material.dart';

import '../../routers.dart';

//var list = new ListNotify();
class ChooseOverLay {
  static OverlayEntry entry;
  static bool isshow = false;
  Animation<double> animation;
  AnimationController controller;
  BuildContext mcontext;
  static ChooseOverLay instance;

  ChooseOverLay(this.mcontext, this.animation, this.controller) {
    animation.addStatusListener((AnimationStatus status) {
      if (animation.value == 0.0 && isshow) {
        Future.delayed(Duration(milliseconds: 0)).then((e) {
          disShow();
          isshow = false;
        });
      } else {
        if (!isshow) {
          Future.delayed(Duration(milliseconds: 0)).then((e) {
            show();
          });

          isshow = true;
        }
      }
    });
  }

  show() {
    OverlayState overlayState = Overlay.of(mcontext);
    entry = new OverlayEntry(builder: _builderToast);
    overlayState.insert(entry);
  }

  disShow() {
    if (entry != null) {
      entry.remove();
      entry = null;
    }
  }

  Widget _builderToast(context) {
    return Positioned(
        top: MediaQuery.of(context).size.height - 180,
        bottom: 90,
        left: 75,
        right: 75,
        child: UnconstrainedBox(
          child: Container(
            width: MediaQuery.of(context).size.width - 150,
            height: 90,
            padding: const EdgeInsets.all(0.0),
            margin: const EdgeInsets.all(0.0),
            child: ScaleTransition(
              //设置动画的缩放中心
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        MyHomePage.of(mcontext).changeChoose();
                        Routers.push(mcontext, Routers.NEWODERONOFFLINE);
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Text(
                            "跑腿",
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      "发布悬赏",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 17,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        MyHomePage.of(mcontext).changeChoose();
                        Routers.push(mcontext, Routers.NEWORDERONNET);
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Text(
                            "网络",
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
