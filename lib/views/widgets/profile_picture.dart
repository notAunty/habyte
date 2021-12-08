import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:habyte/views/constant/colors.dart';

class ProfilePictureUpdate extends StatelessWidget {
  const ProfilePictureUpdate({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      heroTag: 'edit-profile-picture',
      backgroundColor: Colors.white,
      child: const Icon(FeatherIcons.camera, size: 20,),
      onPressed: () {},
    );
  }
}

class ProfilePictureHolder extends StatelessWidget {
  const ProfilePictureHolder({Key? key, this.editable = false, required this.initials, this.radius = 32}) : super(key: key);

  final bool editable;
  final double radius;
  final String initials;

  @override
  Widget build(BuildContext context) {
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
        Padding(
          padding: EdgeInsets.only(top: radius * 0.15),
          child: Text(
            initials,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: radius * 0.9),
          ),
        ),

        if (editable) const Positioned(
          right: 0,
          bottom: 0,
          child: ProfilePictureUpdate(),
        ),
      ],
    );
  }
}
