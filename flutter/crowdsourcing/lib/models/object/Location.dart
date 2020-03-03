class Location {
  String name, phone, provience, city, plot, street;
  int id;
  bool isMain;
  static const String Id  = "id";
  static const String Name = 'name';
  static const String Phone = 'phone';
  static const String Provience = 'provience';
  static const String City = 'city';
  static const String Plot = "plot";
  static const String Street = "street";
  static const String IsMain = "isMain";

  Location(
      {this.id,
        this.name,
      this.phone,
      this.provience,
      this.city,
      this.plot,
      this.street,
      this.isMain});

  static Location fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Location(
      id: map[Id],
        name: map[Name],
        phone: map[Phone],
        provience: map[Provience],
        city: map[City],
        plot: map[Plot],
        isMain: map[IsMain],
        street: map[Street]);
  }

  Map toJson() => {
    Id:id,
        Phone: phone,
        Provience: provience,
        Name: name,
        City: city,
        Plot: plot,
        Street: street,
        IsMain: isMain
      };
}
