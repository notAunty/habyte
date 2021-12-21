import 'package:hive/hive.dart';
import 'package:habyte/views/constant/constants.dart';

part 'hiveAdapter/reward.g.dart';

@HiveType(typeId: 1)
class Reward {
  // Example: R00001
  @HiveField(0)
  late final String id;

  @HiveField(1)
  late final String name;

  @HiveField(2)
  late final int points;

  Reward();

  Reward.fromJson(Map<String, dynamic> json)
      : name = json[REWARD_NAME]!,
        points = json[REWARD_POINTS]!;

  Map<String, dynamic> toMap() => {
        REWARD_ID: id,
        REWARD_NAME: name,
        REWARD_POINTS: points,
      };

  Reward nullClass() => Reward()
    ..id = NULL_STRING_PLACEHOLDER
    ..name = NULL_STRING_PLACEHOLDER
    ..points = NULL_INT_PLACEHOLDER;
}
