import 'package:flutter/material.dart';
import 'package:habyte/models/reward.dart';
import 'package:habyte/viewmodels/reward.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:habyte/views/widgets/text_fields.dart';

class RewardEdit extends StatelessWidget {
  RewardEdit({
    Key? key,
    this.rewardId,
    required this.isUpdate,
  }) : super(key: key);

  final bool isUpdate;
  final String? rewardId;
  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _nameController;
  late TextEditingController _pointsController;

  final RewardVM _rewardVM = RewardVM.getInstance();
  late Reward _reward;

  Map<String, dynamic> getRewardInMapFromControllers() {
    Map<String, dynamic> toBeReturned = {
      REWARD_NAME: _nameController.text,
      REWARD_POINTS: int.parse(_pointsController.text),
    };
    if (!isUpdate) toBeReturned[REWARD_AVAILABLE] = true;
    return toBeReturned;
  }

  @override
  Widget build(BuildContext context) {
    if (rewardId != null) _reward = _rewardVM.retrieveRewardById(rewardId!);
    _nameController =
        TextEditingController(text: (rewardId == null) ? "" : _reward.name);
    _pointsController = TextEditingController(
        text: (rewardId == null) ? "0" : _reward.points.toString());

    return AlertDialog(
      title: Text(isUpdate ? 'Edit reward' : 'Create reward'),
      actions: <Widget>[
        if (isUpdate)
          TextButton(
            onPressed: () => _rewardVM.deleteReward(rewardId!),
            child: Text(
              'Delete',
              style: const TextStyle().copyWith(color: Colors.red),
            ),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (isUpdate) {
                _rewardVM.updateReward(
                    rewardId!, getRewardInMapFromControllers());
              } else {
                _rewardVM.createReward(getRewardInMapFromControllers());
              }

              Navigator.of(context).pop();
            }
          },
          child: const Text('Done'),
        )
      ],
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFieldLabel(
                label: 'Reward Name',
                child: CustomTextField(
                  maxWords: -1,
                  isRequired: true,
                  controller: _nameController,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextFieldLabel(
                label: 'Points to redeem (min 7 pts)',
                child: CustomTextField(
                  minInt: 7,
                  isInt: true,
                  isRequired: true,
                  controller: _pointsController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
