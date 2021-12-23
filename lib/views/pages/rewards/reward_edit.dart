import 'package:flutter/material.dart';
import 'package:habyte/views/widgets/text_fields.dart';

class RewardEdit extends StatelessWidget {
  RewardEdit({
    Key? key,
    required this.rewardId,
    required this.isUpdate,
  }) : super(key: key);

  final bool isUpdate;
  final String rewardId;
  final GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController nameController;
  late TextEditingController pointsController;

  @override
  Widget build(BuildContext context) {
    // TODO: wp - fetch and insert initial values in following 2 lines
    nameController = TextEditingController(text: "");
    pointsController = TextEditingController(text: 0.toString());

    return AlertDialog(
      title: Text(isUpdate ? 'Edit reward' : 'Create reward'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              // TODO: wp - save
              Navigator.of(context).pop();
            }
          },
          child: const Text('Done'),
        )
      ],
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFieldLabel(
                label: 'Reward Name',
                child: CustomTextField(
                  maxWords: -1,
                  isRequired: true,
                  controller: nameController,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextFieldLabel(
                label: 'Points to redeem (min 7 pts)',
                child: CustomTextField(
                  minInt: 7,
                  isInt: true,
                  isRequired: true,
                  controller: pointsController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
