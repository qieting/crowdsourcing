import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  final ImageProvider url;
  final bool download;
  final double height, width;
  final bool big;

  MyImage(this.url,
      {this.download = true, this.width, this.height, this.big = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          big
              ? Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                  return _MyImage(url);
                }))
              : null;
        },
        child: Image(
          image: url,
          width: width,
          height: height,
        ),
      ),
    );
  }
}

class _MyImage extends StatelessWidget {
  final ImageProvider url;
  final bool download;

  _MyImage(this.url, {this.download = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Image(image: url),
      ),
    );
  }
}
