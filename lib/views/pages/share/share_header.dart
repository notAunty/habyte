import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/constant/sizes.dart';

class SharePageHeader extends StatelessWidget {
  const SharePageHeader({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SIDE_PADDING),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(FeatherIcons.x, color: WHITE_01,),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}