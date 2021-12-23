import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/constant/sizes.dart';

class RewardItem extends StatelessWidget {
  const RewardItem({
    Key? key,
    required this.points,
    required this.name,
    required this.onTap,
    required this.onEdit,
  }) : super(key: key);

  final int points;
  final String name;
  final Function onTap;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BORDER_RADIUS)),
      child: ListTile(
        onTap: () => onTap(),
        horizontalTitleGap: 0,
        contentPadding: EdgeInsets.zero,
        tileColor: Theme.of(context).colorScheme.surface,
        leading: Container(
          width: 56,
          color: YELLOW_01.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  points.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const Text('pts'),
              ],
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 4.0),
          child: Text(name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w500)),
        ),
        trailing: IconButton(
          iconSize: 16,
          icon: const Icon(FeatherIcons.edit2),
          onPressed: () => onEdit(),
        ),
      ),
    );
  }
}

class RedeemedRewardItem extends StatelessWidget {
  const RedeemedRewardItem({
    Key? key,
    required this.points,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  final int points;
  final String name;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BORDER_RADIUS)),
      child: Opacity(
        opacity: 0.5,
        child: ListTile(
          onTap: () => onTap(),
          horizontalTitleGap: 0,
          contentPadding: EdgeInsets.zero,
          tileColor: Theme.of(context).colorScheme.surface,
          leading: Container(
            width: 56,
            color: GREY_02.withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    points.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  const Text('pts'),
                ],
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(name,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }
}
