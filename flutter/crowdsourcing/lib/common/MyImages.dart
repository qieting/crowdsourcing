import 'dart:typed_data';

import 'package:crowdsourcing/net/api.dart';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class MyImages{

  static const  String qq_login_white_24X24 ="assets/images/qq_login_white_29X29.png";

  static Future<bool> saveImage(String path) async {
    var response = await MyDio.getImage(path);
    if(response==null){
      return false;
    }
    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    if(result!=null){
      print(result.runtimeType.toString());
      return true;
    }
  }


}