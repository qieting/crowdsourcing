class Location {
  String name, phone, province, city, plot, street, others,town;
  int id;
  bool isMain;
  static const String Id = "id";
  static const String Name = 'name';
  static const String Phone = 'number';
  static const String Province = 'province';
  static const String City = 'city';
  static const String Plot = "plot";
  static const String Town = 'town';
  static const String Street = "street";
  static const String IsMain = "main";
  static const String Others = "others";

  Location(
      {this.id,
      this.name,
      this.phone,
      this.province,
      this.city,
      this.plot,
        this.town,
      this.street,
      this.others,
      this.isMain});

  static Location fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Location(
        id: map[Id],
        town: map[Town],
        name: map[Name],
        phone: map[Phone],
        province: map[Province],
        city: map[City],
        plot: map[Plot],
        others: map[Others],
        isMain: map[IsMain],
        street: map[Street]);
  }

  Map toJson() => {
        Id: id,
        Phone: phone,
        Province: province,
        Name: name,
        City: city,
        Plot: plot,
        Town:town,
        Others: others,
        Street: street,
        IsMain: isMain
      };

  @override
  toString() {
    return this.province == null
        ? "暂无地址设置"
        : this.province + (this.city??"") + (this.plot??"") + (this.town??"")+this.others??"";
  }
}
