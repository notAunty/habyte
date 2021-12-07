class RewardModel {
  late final String id;
  late final String name;
  late final String points;

  RewardModel.fromJson(Map<String, String> json)
      : id = json['id']!,
        name = json['name']!,
        points = json['points']!;

  Map<String, String> toMap() => {"id": id, "name": name, "points": points};
}
