class OffineOrdering {
  int id;

  int peopleId;

  int offineOrderId;

  DateTime createDate;

  DateTime finishDate;

  static const String Id = "id";
  static const String PeopleId = 'peopleId';
  static const String OffineOrderId = 'offineOrderId';
  static const String CreateDate = 'createDate';
  static const String FinishDate = 'finishDate';

  OffineOrdering(
      {this.id,
      this.peopleId,
      this.offineOrderId,
      this.createDate,
      this.finishDate});

  static OffineOrdering fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return OffineOrdering(
        id: map[Id],
        peopleId: map[PeopleId],
        offineOrderId: map[OffineOrderId],
        createDate:  map[CreateDate]!=null? DateTime.fromMillisecondsSinceEpoch(map[CreateDate]):null,
        finishDate: map[FinishDate]!=null?DateTime.fromMillisecondsSinceEpoch(map[FinishDate]):null);
  }

  Map toJson() => {
        Id: id,
        PeopleId: peopleId,
        OffineOrderId: offineOrderId,
        CreateDate: createDate?.millisecondsSinceEpoch,
        FinishDate: finishDate?.millisecondsSinceEpoch
      };
}
