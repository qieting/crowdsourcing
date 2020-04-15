
import 'dart:io';

import 'package:crowdsourcing/net/api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImage extends StatefulWidget {

  _ChooseImageState chooseImage;
  final bool choose ;
  final String url;
  final double widget,height;
  ChooseImage({this.choose=true,this.widget=150,this.height=150,this.url});
  @override
  _ChooseImageState createState(){
    chooseImage =_ChooseImageState();
    return chooseImage;
  }

  get path=>chooseImage.getUrl();
}

class _ChooseImageState extends State<ChooseImage> {


  File _image;

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);

    setState(() {
      _image = image;
    });
  }
  String getUrl(){
   if(_image!=null){
        return _image.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: widget.choose?()async{
          ImageSource i = await showDialog<ImageSource>(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: const Text('请选择图片'),
                  children: <Widget>[
                    SimpleDialogOption(
                      onPressed: () {
                        // 返回1
                        Navigator.pop(context, ImageSource.camera);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: const Text('拍照'),
                      ),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        // 返回2
                        Navigator.pop(context, ImageSource.gallery);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: const Text('图库'),
                      ),
                    ),
                  ],
                );
              });
          if(i!=null){
            getImage(i);
          }
        }:null,
        child: Image(
          height: widget.height,
          width: widget.widget,
          image: _image==null? ( widget.url==null? AssetImage("assets/images/add.png"):
          NetworkImage(widget.url)
          ):FileImage(_image),
        ),
      )
    );
  }
}
