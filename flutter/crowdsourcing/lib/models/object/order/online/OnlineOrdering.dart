import 'dart:convert';

class OnlineOrdering {
  int id;

  int peopleId;

  int onlineOrderId;

  DateTime createDate;
  DateTime submitDate;
  DateTime finishDate;

  Map<int, String> resources;

  static const String Id = "id";
  static const String PeopleId = 'peopleId';
  static const String OnlineOrderId = 'onlineOrderId';
  static const String CreateDate = 'createDate';
  static const String FinishDate = 'finishDate';
  static const String SUBMITTIME = 'submitDate';
  static const String RESOURCES = 'resources';

  OnlineOrdering(
      {this.id,
      this.submitDate,
      this.peopleId,
      this.resources,
      this.onlineOrderId,
      this.createDate,
      this.finishDate});

  static OnlineOrdering fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;
    print(map[RESOURCES]);
    return OnlineOrdering(
        id: map[Id],
        resources: map[RESOURCES] == null
            ? null
            : (json.decode(map[RESOURCES]) as Map).map<int, String>((k, v) {
              return MapEntry(int.parse(k),v);
        }),
        peopleId: map[PeopleId],
        submitDate: map[SUBMITTIME] != null
            ? DateTime.fromMicrosecondsSinceEpoch(map[SUBMITTIME])
            : null,
        onlineOrderId: map[OnlineOrderId],
        createDate: map[CreateDate] != null
            ? DateTime.fromMicrosecondsSinceEpoch(map[CreateDate])
            : null,
        finishDate: map[FinishDate] != null
            ? DateTime.fromMicrosecondsSinceEpoch(map[FinishDate])
            : null);
  }

  Map toJson() => {
        Id: id,
        PeopleId: peopleId,
        RESOURCES: resources==null?null:json.encode(resources),
        OnlineOrderId: onlineOrderId,
        CreateDate: createDate?.microsecondsSinceEpoch,
        SUBMITTIME: submitDate?.microsecondsSinceEpoch,
        FinishDate: finishDate?.microsecondsSinceEpoch
      };
}
