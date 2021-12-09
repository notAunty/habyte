import 'package:habyte/models/reward.dart';
import 'package:habyte/viewmodels/general.dart';

/// **Reward ViewModel Class**
///
/// Involves:
/// - Reward Model
/// - CRUD
/// - Other operations
class Rewards {
  static final Rewards _rewards = Rewards._internal();
  Rewards._internal();

  /// Get the `Reward` instance for user `CRUD` and other operations
  factory Rewards.getInstance() => _rewards;

  final General _general = General.getInstance();
  final BoxType _boxType = BoxType.reward;
  List<RewardModel> _currentRewards = [];

  /// Everytime login, `retrievePreviousLogin()` in general need to call this
  /// to insert the data stored.
  void setCurrentRewards(List<RewardModel> rewardModelList) =>
      _currentRewards = rewardModelList;

  /// **Create Reward** (`C` in CRUD)
  ///
  /// Create reward will need to pass a map with the pairs of key and value
  ///
  /// Below are the keys for creating `Reward`:
  /// - `REWARD_NAME`
  /// - `REWARD_POINTS`
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  void createReward(Map<String, String> rewardJson) {
    RewardModel _rewardModel = RewardModel.fromJson(rewardJson);
    _rewardModel.id = _general.getBoxItemNewId(_boxType);
    _currentRewards.add(_rewardModel);
    _general.addBoxItem(_boxType, _rewardModel.id, _rewardModel);
  }

  /// **Retrieve Reward** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of RewardModel`.
  List<RewardModel> retrieveAllRewards() => _currentRewards;

  /// **Retrieve Reward** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Map`
  /// (converted from `RewardModel`).
  List<Map<String, String>> retrieveAllRewardsInListOfMap() => _toListOfMap();

  /// **Retrieve Reward** (`R` in CRUD)
  ///
  /// Call this function when you need the info from one of the `RewardModel`.
  ///
  /// Parameter required: `id` from `RewardModel`.
  RewardModel retrieveRewardById(String id) =>
      _currentRewards.singleWhere((rewardModel) => rewardModel.id == id);

  /// **Update Reward** (`U` in CRUD)
  ///
  /// Update reward will just need to pass the `id` of the `RewardModel` &
  /// a map with the key and value that need to update
  ///
  /// Below are the fields that can be updated:
  /// - `REWARD_NAME`
  /// - `REWARD_POINTS`
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  void updateReward(String id, Map<String, String> jsonToUpdate) {
    int _index =
        _currentRewards.indexWhere((rewardModel) => rewardModel.id == id);
    RewardModel _updatedRewardModel = RewardModel.fromJson({
      ..._currentRewards[_index].toMap(),
      ...jsonToUpdate,
    });
    _currentRewards[_index] = _updatedRewardModel;
    _general.updateBoxItem(
        _boxType, _updatedRewardModel.id, _updatedRewardModel);
  }

  /// **Delete Reward** (`D` in CRUD)
  ///
  /// Call this function when need to delete reward
  void deleteReward(String id) {
    int index =
        _currentRewards.indexWhere((rewardModel) => rewardModel.id == id);
    String removedId = _currentRewards.removeAt(index).id;
    _general.deleteBoxItem(_boxType, removedId);
  }

  /// Private function to convert `List of RewardModel` to `List of Map`
  List<Map<String, String>> _toListOfMap() {
    List<Map<String, String>> rewardsInListOfMap = [];
    for (RewardModel rewardModel in _currentRewards) {
      rewardsInListOfMap.add(rewardModel.toMap());
    }
    return rewardsInListOfMap;
  }
}
