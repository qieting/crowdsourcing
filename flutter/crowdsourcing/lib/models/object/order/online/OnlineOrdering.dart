import 'dart:convert';

class OnlineOrdering {
  int id;

  int peopleId;

  int onlineOrderId;

  DateTime createDate;
  DateTime submitDate;
  DateTime finishDate;

  String reason;
  Map<int, String> resources;

  static const String Id = "id";
  static const String PeopleId = 'peopleId';
  static const String OnlineOrderId = 'onlineOrderId';
  static const String CreateDate = 'createDate';
  static const String FinishDate = 'finishDate';
  static const String SUBMITTIME = 'submitDate';
  static const String RESOURCES = 'resources';
  static const String REASON ="reason";

  OnlineOrdering(
      {this.id,
        this.reason,
      this.submitDate,
      this.peopleId,
      this.resources,
      this.onlineOrderId,
      this.createDate,
      this.finishDate});

  static OnlineOrdering fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return OnlineOrdering(
        id: map[Id],
        reason: map[REASON],
        resources: map[RESOURCES] == null
            ? null
            : (json.decode(map[RESOURCES]) as Map).map<int, String>((k, v) {
                return MapEntry(int.parse(k), v);
              }),
        peopleId: map[PeopleId],
        submitDate: map[SUBMITTIME] != null
            ? DateTime.fromMillisecondsSinceEpoch(map[SUBMITTIME])
            : null,
        onlineOrderId: map[OnlineOrderId],
        createDate: map[CreateDate] != null
            ? DateTime.fromMillisecondsSinceEpoch(map[CreateDate])
            : null,
        finishDate: map[FinishDate] != null
            ? DateTime.fromMillisecondsSinceEpoch(map[FinishDate])
            : null);
  }

  Map toJson() {
    print(resources.toString());
   // print(json.encode(resources));
    return {
      Id: id,
      REASON:reason,
      PeopleId: peopleId,
      //RESOURCES: resources == null ? null : resources.toString(),
      OnlineOrderId: onlineOrderId,
      CreateDate: createDate?.millisecondsSinceEpoch,
      SUBMITTIME: submitDate?.millisecondsSinceEpoch,
      FinishDate: finishDate?.millisecondsSinceEpoch,
    };
  }
}
