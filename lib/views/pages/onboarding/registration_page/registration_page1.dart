import 'package:flutter/material.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:habyte/views/widgets/text_fields.dart';

class RegistationPage1 extends StatelessWidget {
  RegistationPage1({Key? key, required this.formKey}) : super(key: key);

  final GlobalKey formKey;
  final UserVM _userVM = UserVM.getInstance();

  void addTempName(String value) => _userVM.addTempUserData({USER_NAME: value});
  void addTempAboutMe(String value) => _userVM.addTempUserData({USER_ABOUT: value});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController aboutMeController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              Text(
                'But first, let us know more about you.',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 24),
              CustomTextFieldLabel(
                label: 'Name*',
                child: CustomTextField(
                  maxWords: -1,
                  isRequired: true,
                  controller: nameController,
                  onChanged: (value) => addTempName(value),
                ),
              ),
              const SizedBox(height: 24),
              CustomTextFieldLabel(
                label: 'About me',
                child: CustomTextField(
                  maxWords: -1,
                  isRequired: false,
                  controller: aboutMeController,
                  onChanged: (value) => addTempAboutMe(value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
