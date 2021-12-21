import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:habyte/utils/name_initials.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePictureUpdate extends StatelessWidget {
  const ProfilePictureUpdate({
    Key? key,
    this.mini = true,
    required this.pickImage,
  }) : super(key: key);

  final bool mini;
  final Function pickImage;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: mini,
      heroTag: 'edit-profile-picture',
      backgroundColor: WHITE_01,
      child: const Icon(FeatherIcons.camera, size: 20, color: BLACK_02),
      onPressed: () => pickImage(),
    );
  }
}

class ProfilePictureHolder extends StatefulWidget {
  const ProfilePictureHolder({
    Key? key,
    this.editable = false,
    this.radius = 32,
    this.isRegistering = false,
  }) : super(key: key);

  final bool editable;
  final double radius;
  final bool isRegistering;

  @override
  _ProfilePictureHolderState createState() => _ProfilePictureHolderState();
}

class _ProfilePictureHolderState extends State<ProfilePictureHolder> {
  final UserVM _userVM = UserVM.getInstance();

  void _imgFromGallery(bool isRegistering) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String filePath = '${appDir.path}/${image.name}';
      await image.saveTo(filePath);
      image = null;

      Map<String, dynamic> jsonToUpdate = {USER_PROFILE_PIC_PATH: filePath};

      setState(() => isRegistering
          ? _userVM.addTempUserData(jsonToUpdate)
          : _userVM.updateUser(jsonToUpdate));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool editable = widget.editable;
    double radius = widget.radius;
    bool isRegistering = widget.isRegistering;

    final String? _userName = isRegistering
        ? _userVM.retrieveTempUserJson()[USER_NAME]
        : _userVM.retrieveUser()!.toMap()[USER_NAME];
    final String? _profilePicPath = isRegistering
        ? _userVM.retrieveTempUserJson()[USER_PROFILE_PIC_PATH]
        : _userVM.retrieveUser()!.toMap()[USER_PROFILE_PIC_PATH];

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: radius * 2,
          width: radius * 2,
          decoration: BoxDecoration(
              color: WHITE_01,
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 2,
                  color: Colors.black.withOpacity(0.2),
                ),
              ]),
        ),
        // CircleAvatar(
        //   radius: radius,
        //   backgroundColor: Theme.of(context).colorScheme.surface,
        // ),
        // CircleAvatar(
        //   radius: radius - (radius * 0.075),
        //   backgroundColor: Theme.of(context).colorScheme.secondary,
        // ),
        Container(
          height: (radius - (radius * 0.05)) * 2,
          width: (radius - (radius * 0.05)) * 2,
          decoration: BoxDecoration(
              color: BLUE_03,
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.2),
                ),
              ]),
        ),
        if (_profilePicPath != null && _profilePicPath != "")
          Container(
            child: Image.file(
              File(_profilePicPath),
              fit: BoxFit.cover,
            ),
            height: (radius - (radius * 0.05)) * 2,
            width: (radius - (radius * 0.05)) * 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
            ),
          )
        else
          Padding(
            padding: EdgeInsets.only(top: radius * 0.15),
            child: Text(
              getNameInitials(_userName).toUpperCase(),
              style: TextStyle(
                  color: WHITE_01,
                  fontWeight: FontWeight.w600,
                  fontSize: radius * 0.9),
            ),
          ),

        if (editable)
          Positioned(
            right: 0,
            bottom: 0,
            child: ProfilePictureUpdate(
              mini: radius < 96,
              pickImage: () => _imgFromGallery(isRegistering),
            ),
          ),
      ],
    );
  }
}
