import 'package:habyte/models/reward.dart';
import 'package:habyte/viewmodels/general.dart';

class Rewards {
  static final Rewards _rewards = Rewards._internal();
  factory Rewards.getInstance() => _rewards;
  Rewards._internal();

  BoxType boxType = BoxType.reward;

  final General _general = General.getInstance();

  late final List<RewardModel> _currentRewards;

  void setCurrentRewards(List<RewardModel> rewardModelList) {
    _currentRewards = rewardModelList;
  }

  List<Map<String, String>> _toListOfMap() {
    List<Map<String, String>> rewardsInListOfMap = [];
    for (RewardModel rewardModel in _currentRewards) {
      rewardsInListOfMap.add(rewardModel.toMap());
    }
    return rewardsInListOfMap;
  }

  //// CRUD
  // C
  void createReward(RewardModel rewardModel) {
    rewardModel.id = _general.getBoxItemNewId(boxType);
    _currentRewards.add(rewardModel);
    _general.addBoxItem(boxType, rewardModel.id, rewardModel);
  }

  // R
  List<RewardModel> retrieveAllRewards() => _currentRewards;
  List<Map<String, String>> retrieveAllRewardsInListOfMap() => _toListOfMap();

  // r
  RewardModel retrieveRewardById(String id) =>
      _currentRewards.singleWhere((rewardModel) => rewardModel.id == id);

  // U
  void updateReward(String id, RewardModel updatedRewardModel) {
    int index =
        _currentRewards.indexWhere((rewardModel) => rewardModel.id == id);
    updatedRewardModel.id = _currentRewards[index].id;
    _currentRewards[index] = updatedRewardModel;
    _general.updateBoxItem(boxType, updatedRewardModel.id, updatedRewardModel);
  }

  // D
  void deleteReward(String id) {
    int index =
        _currentRewards.indexWhere((rewardModel) => rewardModel.id == id);
    String removedId = _currentRewards.removeAt(index).id;
    _general.deleteBoxItem(boxType, removedId);
  }
  ////
}
