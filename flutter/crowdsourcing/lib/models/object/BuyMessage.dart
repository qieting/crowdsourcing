import 'Location.dart';

class BuyMessage {
  double price;
  Location location;
  String describe, goods;

  static const String PRICE = 'price';
  static const String LOCATION = 'location';
  static const String Describe = 'describe';
  static const String Goods = 'goods';

  BuyMessage({this.location, this.price, this.describe, this.goods});

  static BuyMessage fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return BuyMessage(
        location: Location.fromJsonMap(map[LOCATION]),
        price: map[PRICE],
        goods: map[Goods],
        describe: map[Describe]);
  }

  Map toJson() =>
      {LOCATION: location.toJson(), PRICE: price, Goods: goods, Describe: describe};
}
