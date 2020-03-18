class MyPoi {
  final String name, address;

  MyPoi({this.name, this.address});

  static const String Name = 'name';
  static const String Address = 'address';

  static MyPoi fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MyPoi user = MyPoi(name: map[Name], address: map[Address]);
    return user;
  }

  Map toJson() => {Name: name, Address: address};
}
