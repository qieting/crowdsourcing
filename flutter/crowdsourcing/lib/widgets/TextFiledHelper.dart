import 'package:flutter/material.dart';

class MyDecoration{

  static copyBorder(InputDecoration inputDecoration){
    return inputDecoration.copyWith(
      border: inputDecoration.border,
      disabledBorder: inputDecoration.border,
      focusedBorder: inputDecoration.border,
    );
  }


}
