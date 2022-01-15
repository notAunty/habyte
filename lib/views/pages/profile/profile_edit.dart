import 'package:flutter/material.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/widgets/profile_picture.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:habyte/views/widgets/text_fields.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);
  // EditProfilePage({Key? key, required this.setState}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();
  final UserVM _userVM = UserVM.getInstance();

  void addTempFirstName(String firstName) =>
      _userVM.addTempUserData({USER_FIRST_NAME: firstName});
  void addTempLastName(String lastName) =>
      _userVM.addTempUserData({USER_LAST_NAME: lastName});
  void addTempAbout(String about) =>
      _userVM.addTempUserData({USER_ABOUT: about});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController(
        text: _userVM.retrieveTempUserJson()[USER_FIRST_NAME]);
    TextEditingController lastNameController = TextEditingController(
        text: _userVM.retrieveTempUserJson()[USER_LAST_NAME]);
    TextEditingController aboutController =
        TextEditingController(text: _userVM.retrieveTempUserJson()[USER_ABOUT]);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SIDE_PADDING),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: TOP_PADDING, width: double.infinity),
                const ProfilePictureHolder(
                  radius: 64,
                  editable: true,
                ),
                const SizedBox(height: 24),
                CustomTextFieldLabel(
                  label: 'First Name*',
                  child: CustomTextField(
                    maxWords: -1,
                    isRequired: true,
                    controller: firstNameController,
                    onChanged: (value) => addTempFirstName(value),
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextFieldLabel(
                  label: 'Last Name*',
                  child: CustomTextField(
                    maxWords: -1,
                    isRequired: true,
                    controller: lastNameController,
                    onChanged: (value) => addTempLastName(value),
                  ),
                ),
                const SizedBox(height: TOP_PADDING),
                CustomTextFieldLabel(
                  label: 'About',
                  child: CustomTextField(
                    maxWords: -1,
                    isRequired: false,
                    controller: aboutController,
                    onChanged: (about) => addTempAbout(about),
                    isMultiline: true,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 32,
                  child: ElevatedButton(
                    child: const Text('Done'),
                    onPressed: () {
                      _userVM.updateUser(_userVM.retrieveTempUserJson());
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(height: TOP_PADDING),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
