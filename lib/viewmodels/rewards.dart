import 'package:habyte/models/reward.dart';

class Rewards {
  static final Rewards _rewards = Rewards._internal();
  factory Rewards.getInstance() => _rewards;
  Rewards._internal();

  final List<RewardModel> _currentRewards = [];

  void setCurrentRewards(List<Map<String, String>> rewardJsonList) {
    for (Map<String, String> rewardJson in rewardJsonList) {
      _currentRewards.add(RewardModel.fromJson(rewardJson));
    }
  }

  List<Map<String, String>> toListOfMap() {
    List<Map<String, String>> rewardsInListOfMap = [];
    for (RewardModel rewardModel in _currentRewards) {
      rewardsInListOfMap.add(rewardModel.toMap());
    }
    return rewardsInListOfMap;
  }

  //// CRUD
  // C
  void createReward(RewardModel rewardModel) =>
      _currentRewards.add(rewardModel);

  // R
  List<RewardModel> retrieveAllRewards() => _currentRewards;

  // r
  // Error Handling need to do for this, either do here or do in main code
  RewardModel retrieveRewardById(String id) =>
      _currentRewards.where((rewardModel) => rewardModel.id == id).toList()[0];

  // U
  void updateReward(String id, RewardModel updatedRewardModel) {
    int index =
        _currentRewards.indexWhere((rewardModel) => rewardModel.id == id);
    _currentRewards[index] = updatedRewardModel;
  }

  // D
  void deleteReward(String id) =>
      _currentRewards.removeWhere((rewardModel) => rewardModel.id == id);
  ////
}
