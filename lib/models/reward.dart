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

  @HiveField(3)
  late final bool available;

  Reward();

  Reward.createFromJson(Map<String, dynamic> json)
      : name = json[REWARD_NAME],
        points = json[REWARD_POINTS],
        available = json[REWARD_AVAILABLE];

  Reward.fromJson(Map<String, dynamic> json)
      : id = json[REWARD_ID],
        name = json[REWARD_NAME],
        points = json[REWARD_POINTS],
        available = json[REWARD_AVAILABLE];

  Map<String, dynamic> toMap() => {
        REWARD_ID: id,
        REWARD_NAME: name,
        REWARD_POINTS: points,
        REWARD_AVAILABLE: available
      };

  Reward.nullClass()
      : id = NULL_STRING_PLACEHOLDER,
        name = NULL_STRING_PLACEHOLDER,
        points = NULL_INT_PLACEHOLDER,
        available = NULL_BOOL_PLACEHOLDER;
}
