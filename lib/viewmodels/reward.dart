import 'package:habyte/models/reward.dart';
import 'package:habyte/viewmodels/general.dart';

/// **Reward ViewModel Class**
///
/// Involves:
/// - Reward Model
/// - CRUD
/// - Other operations
class RewardVM {
  static final RewardVM _rewardVM = RewardVM._internal();
  RewardVM._internal();

  /// Get the `Reward` instance for user `CRUD` and other operations
  factory RewardVM.getInstance() => _rewardVM;

  final General _general = General.getInstance();
  final BoxType _boxType = BoxType.reward;
  List<Reward> _currentRewards = [];

  /// Everytime login, `retrievePreviousLogin()` in general need to call this
  /// to insert the data stored.
  void setCurrentRewards(List<Reward> rewardList) =>
      _currentRewards = rewardList;

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
    Reward _reward = Reward.fromJson(rewardJson);
    _reward.id = _general.getBoxItemNewId(_boxType);
    _currentRewards.add(_reward);
    _general.addBoxItem(_boxType, _reward.id, _reward);
  }

  /// **Retrieve Reward** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Reward`.
  List<Reward> retrieveAllRewards() => _currentRewards;

  /// **Retrieve Reward** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Map`
  /// (converted from `Reward`).
  List<Map<String, String>> retrieveAllRewardsInListOfMap() => _toListOfMap();

  /// **Retrieve Reward** (`R` in CRUD)
  ///
  /// Call this function when you need the info from one of the `Reward`.
  ///
  /// Parameter required: `id` from `Reward`.
  Reward retrieveRewardById(String id) =>
      _currentRewards.singleWhere((reward) => reward.id == id);

  /// **Update Reward** (`U` in CRUD)
  ///
  /// Update reward will just need to pass the `id` of the `Reward` &
  /// a map with the key and value that need to update
  ///
  /// Below are the fields that can be updated:
  /// - `REWARD_NAME`
  /// - `REWARD_POINTS`
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  void updateReward(String id, Map<String, String> jsonToUpdate) {
    int _index = _currentRewards.indexWhere((reward) => reward.id == id);
    Reward _updatedReward = Reward.fromJson({
      ..._currentRewards[_index].toMap(),
      ...jsonToUpdate,
    });
    _currentRewards[_index] = _updatedReward;
    _general.updateBoxItem(_boxType, _updatedReward.id, _updatedReward);
  }

  /// **Delete Reward** (`D` in CRUD)
  ///
  /// Call this function when need to delete reward
  void deleteReward(String id) {
    int index = _currentRewards.indexWhere((reward) => reward.id == id);
    String removedId = _currentRewards.removeAt(index).id;
    _general.deleteBoxItem(_boxType, removedId);
  }

  /// Private function to convert `List of Reward` to `List of Map`
  List<Map<String, String>> _toListOfMap() {
    List<Map<String, String>> rewardsInListOfMap = [];
    for (Reward reward in _currentRewards) {
      rewardsInListOfMap.add(reward.toMap());
    }
    return rewardsInListOfMap;
  }
}
