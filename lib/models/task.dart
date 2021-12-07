class TaskModel {
  late final String id;
  late final String name;
  late final int points;  // I think we can fix it like 1 - 5
  late final DateTime startDate;
  late final DateTime? endDate;
  // so that we can track how many days left behind to deduct score
  late final DateTime lastCompleteDate;

  TaskModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        points = json['points'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        lastCompleteDate = json['lastCompleteDate'];

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "points": points,
        "startDate": startDate,
        "endDate": endDate,
        "lastCompleteDate": lastCompleteDate
      };
}
