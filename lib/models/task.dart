class TaskModel {
  late final String id;
  late final String name;
  late final int frequencyPerWeek;
  late final int completedCountPerWeek;
  late final DateTime startDate;
  late final DateTime? endDate;

  TaskModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        frequencyPerWeek = json['frequencyPerWeek'],
        completedCountPerWeek = json['completedCountPerWeek'],
        startDate = json['startDate'],
        endDate = json['endDate'];

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "frequencyPerWeek": frequencyPerWeek,
        "completedCountPerWeek": completedCountPerWeek,
        "startDate": startDate,
        "endDate": endDate
      };
}
