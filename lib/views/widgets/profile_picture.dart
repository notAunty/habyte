import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/colors.dart';
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
      backgroundColor: Colors.white,
      child: const Icon(
        FeatherIcons.camera,
        size: 20,
      ),
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

    setState(() {
      _user.editProfilePicture(filePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool editable = widget.editable;
    double radius = widget.radius;
    String initials = widget.initials;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: radius * 2,
          width: radius * 2,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 2,
                  color: GREY_02.withOpacity(0.3),
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
                  blurRadius: 2,
                  spreadRadius: 2,
                  color: GREY_02.withOpacity(0.1),
                ),
              ]),
        ),
        if (_user.currentUser != null)
          if (_user.currentUser?.profilePicPath != null ||
              _user.currentUser?.profilePicPath == "")
            Container(
              child: Image.file(
                File(_user.currentUser?.profilePicPath ?? ""),
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
              _user.currentUser!.name[0],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: radius * 0.9),
            )
        else
          Text(
            initials,
            style: TextStyle(
                color: Colors.white,
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
