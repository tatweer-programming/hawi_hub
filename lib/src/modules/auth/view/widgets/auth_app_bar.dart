import 'package:flutter/material.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/modules/auth/data/models/player.dart';
import 'package:hawihub/src/modules/auth/view/screens/update_profile_screen.dart';
import 'package:hawihub/src/modules/auth/view/widgets/widgets.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

class AuthAppBar extends StatelessWidget {
  final BuildContext context;
  final Player player;
  final String title;
  final Widget? widget;

  const AuthAppBar(
      {super.key,
      required this.context,
      required this.player,
      this.widget,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CustomAppBar(
          blendMode: BlendMode.exclusion,
          backgroundImage: "assets/images/app_bar_backgrounds/4.webp",
          height: 32.h,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 2.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                backIcon(context),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorManager.white,
                    fontSize: 32.sp,
                  ),
                ),
                widget ??
                    SizedBox(
                      width: 10.w,
                    ),
              ],
            ),
          ),
        ),
        CircleAvatar(
          radius: 50.sp,
          backgroundColor: ColorManager.grey3,
          backgroundImage: player.profilePictureUrl != null
              ? NetworkImage(player.profilePictureUrl!)
              : const AssetImage("assets/images/icons/user.png")
                  as ImageProvider<Object>,
        ),
      ],
    );
  }
}
