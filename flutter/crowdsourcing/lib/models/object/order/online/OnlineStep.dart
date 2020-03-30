enum MyAction { upQR, graphicShows, URL, upImage, upPhone }

class OnlineStep {
  String name,
      //文字说明
      explain,
      //这个url上传初期是本地图片，后期是网图
      imageUrl;

  MyAction myAction;

  static const String NAME = "name";
  static const String EXPLAIN = 'explain';
  static const String IMAGEURL = 'iamgeUrl';
  static const String MYACTION = 'myAction';

  OnlineStep({this.name, this.explain, this.imageUrl, this.myAction});

  static OnlineStep fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return OnlineStep(
        name: map[NAME],
        explain: map[EXPLAIN],
        imageUrl: map[IMAGEURL],
        myAction: MyAction.values[map[MYACTION]]);
  }

  Map toJson() =>
      {NAME: name, EXPLAIN: explain, IMAGEURL: imageUrl, MYACTION: myAction.index};
}
