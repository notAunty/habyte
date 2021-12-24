import 'package:flutter/material.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/widgets/profile_picture.dart';
import 'package:habyte/views/widgets/appbar_widget.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:habyte/views/widgets/text_fields.dart';
import 'package:habyte/views/pages/profile/_profile.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<EditProfilePage> {
  final UserVM _userVM = UserVM.getInstance();

  void addTempFirstName(String firstName) =>
      _userVM.addTempUserData({USER_FIRST_NAME: firstName});
  void addTempLastName(String lastName) =>
      _userVM.addTempUserData({USER_LAST_NAME: lastName});
  void addTempAbout(String about) =>
      _userVM.addTempUserData({USER_ABOUT: about});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController aboutController = TextEditingController();

    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: TOP_PADDING, width: double.infinity),
          const ProfilePictureHolder(
            radius: 64,
            editable: true,
          ),
          const SizedBox(height: TOP_PADDING),
          buildName(_userVM),
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
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildName(UserVM _userVM) {
    final String _userFirstName =
        _userVM.retrieveTempUserJson()[USER_FIRST_NAME];
    final String _userLastName = _userVM.retrieveTempUserJson()[USER_LAST_NAME];
    return Column(
      children: [
        Text(
          '$_userFirstName $_userLastName',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ],
    );
  }
}
