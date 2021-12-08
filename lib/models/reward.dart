import 'package:hive/hive.dart';

part 'hiveAdapter/reward.g.dart';

@HiveType(typeId: 1)
class RewardModel {
  // Example: R00001
  @HiveField(0)
  late final String id;

  @HiveField(1)
  late final String name;

  @HiveField(2)
  late final String points;

  RewardModel();

  RewardModel.fromJson(Map<String, String> json)
      : name = json['name']!,
        points = json['points']!;

  Map<String, String> toMap() => {"id": id, "name": name, "points": points};
}
