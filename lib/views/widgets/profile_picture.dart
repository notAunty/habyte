import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:habyte/models/user.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePictureUpdate extends StatelessWidget {
  const ProfilePictureUpdate({Key? key, required this.pickImage})
      : super(key: key);

  final Function pickImage;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      heroTag: 'edit-profile-picture',
      backgroundColor: WHITE_01,
      child: const Icon(FeatherIcons.camera, size: 20),
      onPressed: () => pickImage(),
    );
  }
}

class ProfilePictureHolder extends StatefulWidget {
  const ProfilePictureHolder({
    Key? key,
    this.editable = false,
    required this.initials,
    this.radius = 32,
  }) : super(key: key);

  final bool editable;
  final double radius;
  final String initials;

  @override
  _ProfilePictureHolderState createState() => _ProfilePictureHolderState();
}

class _ProfilePictureHolderState extends State<ProfilePictureHolder> {
  final User _user = User.getInstance();

  void _imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    final Directory appDir = await getApplicationDocumentsDirectory();
    final String filePath = '${appDir.path}/${image?.name}';
    await image!.saveTo(filePath);
    image = null;

    setState(() => _user.updateUser({USER_PROFILE_PIC_PATH: filePath}));
  }

  @override
  Widget build(BuildContext context) {
    bool editable = widget.editable;
    double radius = widget.radius;
    String initials = widget.initials;

    UserModel? _userModel = _user.retrieveUser();

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
        if (_userModel != null)
          if (_userModel.profilePicPath != null ||
              _userModel.profilePicPath == "")
            Container(
              child: Image.file(
                File(_userModel.profilePicPath ?? ""),
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
            Text(
              _userModel.name[0].toUpperCase(),
              style: TextStyle(
                  color: WHITE_01,
                  fontWeight: FontWeight.w600,
                  fontSize: radius * 0.9),
            )
        else
          Text(
            initials,
            style: TextStyle(
                color: WHITE_01,
                fontWeight: FontWeight.w600,
                fontSize: radius * 0.9),
          ),

        if (editable)
          Positioned(
            right: 0,
            bottom: 0,
            child: ProfilePictureUpdate(
              pickImage: () => _imgFromGallery(),
            ),
          ),
      ],
    );
  }
}
