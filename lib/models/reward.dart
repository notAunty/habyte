import 'package:habyte/views/constant/constants.dart';
import 'package:hive/hive.dart';

part 'hiveAdapter/reward.g.dart';

@HiveType(typeId: 1)
class Reward {
  // Example: R00001
  @HiveField(0)
  late final String id;

  @HiveField(1)
  late final String name;

  @HiveField(2)
  late final String points;

  Reward();

  Reward.fromJson(Map<String, String> json)
      : name = json[REWARD_NAME]!,
        points = json[REWARD_POINTS]!;

  Map<String, String> toMap() => {
        REWARD_ID: id,
        REWARD_NAME: name,
        REWARD_POINTS: points,
      };
}
