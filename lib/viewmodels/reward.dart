import 'package:habyte/models/reward.dart';
import 'package:habyte/viewmodels/general.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/constants.dart';

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
  /// Return the created reward
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  Reward createReward(Map<String, dynamic> rewardJson) {
    Reward _reward = Reward.fromJson(rewardJson);
    _reward.id = _general.getBoxItemNewId(_boxType);
    _currentRewards.add(_reward);
    _general.addBoxItem(_boxType, _reward.id, _reward);
    return _reward;
  }

  /// **Retrieve Reward** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Reward`.
  List<Reward> retrieveAllRewards() => _currentRewards;

  /// **Retrieve Reward (Split)** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Reward` (
  /// `available` and `redeemed` in different list).
  Map<String, List<Reward>> retrieveAllSplitRewards() =>
      _splitAvailableRedeemed() as Map<String, List<Reward>>;

  /// **Retrieve Reward** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Map`
  /// (converted from `Reward`).
  List<Map<String, dynamic>> retrieveAllRewardsInListOfMap() => _toListOfMap();

  /// **Retrieve Reward** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Map`
  /// (converted from `Reward` - `available` and `redeemed` in different list).
  Map<String, List<Map<String, dynamic>>>
      retrieveAllAplitRewardsInListOfMap() =>
          _splitAvailableRedeemed(toMap: true)
              as Map<String, List<Map<String, dynamic>>>;

  /// **Retrieve Reward** (`R` in CRUD)
  ///
  /// Call this function when you need the info from one of the `Reward`.
  ///
  /// Parameter required: `id` from `Reward`.
  Reward retrieveRewardById(String id) => _currentRewards.singleWhere(
        (reward) => reward.id == id,
        orElse: () => Reward().nullClass(),
      );

  /// **Update Reward** (`U` in CRUD)
  ///
  /// Update reward will just need to pass the `id` of the `Reward` &
  /// a map with the key and value that need to update
  ///
  /// Below are the fields that can be updated:
  /// - `REWARD_NAME`
  /// - `REWARD_POINTS`
  ///
  /// Return the created reward
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  Reward updateReward(String id, Map<String, dynamic> jsonToUpdate) {
    int _index = _currentRewards.indexWhere((reward) => reward.id == id);
    // if (_index == -1) // do some alert
    Reward _updatedReward = Reward.fromJson({
      ..._currentRewards[_index].toMap(),
      ...jsonToUpdate,
    });
    _updatedReward.id = id;
    _currentRewards[_index] = _updatedReward;
    _general.updateBoxItem(_boxType, _updatedReward.id, _updatedReward);
    return _updatedReward;
  }

  /// **Delete Reward** (`D` in CRUD)
  ///
  /// Call this function when need to delete reward
  void deleteReward(String id) {
    _currentRewards.removeWhere((reward) => reward.id == id);
    _general.deleteBoxItem(_boxType, id);
  }

  /// Call this function when user redeem the reward
  void redeemReward(String id) {
    Reward redeemedReward = updateReward(id, {REWARD_AVAILABLE: false});
    UserVM.getInstance().deductPoint(redeemedReward.points);
  }

  Map<String, List<dynamic>> _splitAvailableRedeemed({bool toMap = false}) {
    Map<String, List<dynamic>> splitRewards = {
      REWARD_AVAILABLE: [],
      REWARD_REDEEMED: []
    };

    for (var reward in _currentRewards) {
      if (reward.available) {
        splitRewards[REWARD_AVAILABLE]!.add(toMap ? reward.toMap() : reward);
      } else {
        splitRewards[REWARD_REDEEMED]!.add(reward);
      }
    }

    return splitRewards;
  }

  /// Private function to convert `List of Reward` to `List of Map`
  List<Map<String, dynamic>> _toListOfMap() {
    List<Map<String, dynamic>> rewardsInListOfMap = [];
    for (Reward reward in _currentRewards) {
      rewardsInListOfMap.add(reward.toMap());
    }
    return rewardsInListOfMap;
  }
}
