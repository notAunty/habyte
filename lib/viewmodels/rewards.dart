import 'package:habyte/models/reward.dart';

class Rewards {
  static final Rewards _rewards = Rewards._internal();
  factory Rewards.getInstance() => _rewards;
  Rewards._internal();

  List<RewardModel> currentRewards = [];

  void setCurrentRewards(List<Map<String, String>> rewardJsonList) {
    for (Map<String, String> rewardJson in rewardJsonList) {
      currentRewards.add(RewardModel.fromJson(rewardJson));
    }
  }

  void toListOfMap() {
    List<Map<String, String>> rewardsInListOfMap = [];
    for (RewardModel rewardModel in currentRewards) {
      rewardsInListOfMap.add(rewardModel.toMap());
    }
  }

  void createReward(RewardModel rewardModel) => currentRewards.add(rewardModel);

  void retrieveReward(String id) =>
      currentRewards.where((rewardModel) => rewardModel.id == id);

  void updateReward(String id, RewardModel updatedRewardModel) {
    int index =
        currentRewards.indexWhere((rewardModel) => rewardModel.id == id);
    currentRewards[index] = updatedRewardModel;
  }

  void deleteReward(String id) {
    int index =
        currentRewards.indexWhere((rewardModel) => rewardModel.id == id);
    currentRewards.removeAt(index);
  }
}
