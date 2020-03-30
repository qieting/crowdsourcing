


import 'dart:collection';

import 'package:crowdsourcing/widgets/ChooseImage/ChooseImage.dart';
import 'package:flutter/cupertino.dart';

class ListOfChooseImage{

  Map<int ,ChooseImage> map = HashMap();


  ChooseImage operator[](int index){
    if(map[index]==null){
      map[index]=ChooseImage();
    }
    return map[index];

  }

  bool valiad(){
    bool vv =true;
    map.forEach((k,v){
      if(v.path==null){
        vv=false;
      }
    });

    return vv;
  }



}


class ListOfTextEditingController{

  Map<int ,TextEditingController> map = HashMap();


  TextEditingController operator[](int index){
    if(map[index]==null){
      map[index]=TextEditingController();
    }
    return map[index];
  }
  bool valiad(){
    bool vv =true;
    map.forEach((k,v){
      if(v.text.length==0){
        vv=false;
      }
    });

    return vv;
  }
}