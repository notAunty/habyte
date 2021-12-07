class EntryModel {
  late final String id;
  late final String taskId;
  late final DateTime completedDate;

  EntryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        taskId = json['taskId'],
        completedDate = json['completedDate'];

  Map<String, dynamic> toMap() =>
      {"id": id, "taskId": taskId, "completedDate": completedDate};
}
