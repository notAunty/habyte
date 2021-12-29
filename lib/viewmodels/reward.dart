import 'package:habyte/models/reward.dart';
import 'package:habyte/viewmodels/general.dart';
import 'package:habyte/viewmodels/notifiers.dart';
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
  final Notifiers _notifiers = Notifiers.getInstance();
  final NotifierType _availableRewardsNotifierType =
      NotifierType.availableRewards;
  final NotifierType _redeemedRewardsNotifierType =
      NotifierType.redeemedRewards;
  List<Reward> _currentRewards = [];

  /// Everytime login, `retrievePreviousLogin()` in general need to call this
  /// to insert the data stored.
  void setCurrentRewards(List<Reward> rewardList) {
    _currentRewards = rewardList;
    print(_toListOfMap());
    Map<String, List<Map<String, dynamic>>> splitRewards =
        _splitAvailableRedeemedInListOfMap();
    if (splitRewards[REWARD_AVAILABLE] != null) {
      for (int i = 0; i < splitRewards[REWARD_AVAILABLE]!.length; i++) {
        _notifiers.addNotifierValue(
            _availableRewardsNotifierType, splitRewards[REWARD_AVAILABLE]![i]);
      }
    }
    if (splitRewards[REWARD_REDEEMED] != null) {
      for (int i = 0; i < splitRewards[REWARD_REDEEMED]!.length; i++) {
        _notifiers.addNotifierValue(
            _redeemedRewardsNotifierType, splitRewards[REWARD_REDEEMED]![i]);
      }
    }
  }

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

    _notifiers.addNotifierValue(_availableRewardsNotifierType, _reward.toMap());

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
      _splitAvailableRedeemed();

  /// **Retrieve Reward (Split)** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Reward` (
  /// `available`).
  List<Reward> retrieveAllAvailableRewards() =>
      _splitAvailableRedeemed()[REWARD_AVAILABLE] as List<Reward>;

  /// **Retrieve Reward (Split)** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Reward` (
  /// `redeemed`).
  List<Reward> retrieveAllRedeemedRewards() =>
      _splitAvailableRedeemed()[REWARD_REDEEMED] as List<Reward>;

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
          _splitAvailableRedeemed() as Map<String, List<Map<String, dynamic>>>;

  /// **Retrieve Reward (Split)** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Reward` (
  /// `available`).
  List<Map<String, dynamic>>? retrieveAllAvailableRewardsInListOfMap() =>
      _splitAvailableRedeemedInListOfMap()[REWARD_AVAILABLE]
          as List<Map<String, dynamic>>;

  /// **Retrieve Reward (Split)** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Reward` (
  /// `redeemed`).
  List<Map<String, dynamic>> retrieveAllRedeemedRewardsInListOfMap() =>
      _splitAvailableRedeemedInListOfMap()[REWARD_REDEEMED]
          as List<Map<String, dynamic>>;

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

    _notifiers.updateNotifierValue(
        _availableRewardsNotifierType, _updatedReward.toMap());

    return _updatedReward;
  }

  /// **Delete Reward** (`D` in CRUD)
  ///
  /// Call this function when need to delete reward
  void deleteReward(String id) {
    int index = _currentRewards.indexWhere((reward) => reward.id == id);
    Reward deletedReward = _currentRewards.removeAt(index);
    _general.deleteBoxItem(_boxType, id);

    _notifiers.removeOrDeductNotifierValue(
        _availableRewardsNotifierType, deletedReward.toMap());
  }

  /// Call this function when user redeem the reward
  bool redeemReward(String id) {
    bool successDeduct =
        UserVM.getInstance().deductPoint(retrieveRewardById(id).points);
    if (!successDeduct) return false;

    Reward redeemedReward = updateReward(id, {REWARD_AVAILABLE: false});

    print(_toListOfMap());
    _notifiers.removeOrDeductNotifierValue(
        _availableRewardsNotifierType, redeemedReward.toMap());
    _notifiers.addNotifierValue(
        _redeemedRewardsNotifierType, redeemedReward.toMap());
    return true;
  }

  Map<String, List<Reward>> _splitAvailableRedeemed() {
    Map<String, List<Reward>> splitRewards = {
      REWARD_AVAILABLE: [],
      REWARD_REDEEMED: []
    };

    for (Reward reward in _currentRewards) {
      if (reward.available) {
        splitRewards[REWARD_AVAILABLE]!.add(reward);
      } else {
        splitRewards[REWARD_REDEEMED]!.add(reward);
      }
    }

    return splitRewards;
  }

  Map<String, List<Map<String, dynamic>>> _splitAvailableRedeemedInListOfMap() {
    Map<String, List<Map<String, dynamic>>> splitRewards = {
      REWARD_AVAILABLE: [],
      REWARD_REDEEMED: []
    };

    for (Reward reward in _currentRewards) {
      if (reward.available) {
        splitRewards[REWARD_AVAILABLE]!.add(reward.toMap());
      } else {
        splitRewards[REWARD_REDEEMED]!.add(reward.toMap());
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
