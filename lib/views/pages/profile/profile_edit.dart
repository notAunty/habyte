import 'package:flutter/material.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/widgets/profile_picture.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:habyte/views/widgets/text_fields.dart';
import 'package:habyte/views/pages/profile/_profile.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final UserVM _userVM = UserVM.getInstance();

  void addTempFirstName(String firstName) =>
      _userVM.addTempUserData({USER_FIRST_NAME: firstName});
  void addTempLastName(String lastName) =>
      _userVM.addTempUserData({USER_LAST_NAME: lastName});
  void addTempAbout(String about) =>
      _userVM.addTempUserData({USER_ABOUT: about});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController =
        TextEditingController(text: _userVM.retrieveUser()!.firstName);
    TextEditingController lastNameController =
        TextEditingController(text: _userVM.retrieveUser()!.lastName);
    TextEditingController aboutController =
        TextEditingController(text: _userVM.retrieveUser()!.about);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SIDE_PADDING),
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
                  isRequired: true,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                ),
              ),
              const SizedBox(height: TOP_PADDING),
            ],
          ),
        ),
      ),
    );
  }
}
