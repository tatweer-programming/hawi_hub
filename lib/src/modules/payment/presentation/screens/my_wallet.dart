import 'package:flutter/material.dart';
import 'package:hawihub/src/modules/auth/data/models/player.dart';
import 'package:hawihub/src/modules/auth/view/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../main/view/widgets/custom_app_bar.dart';

class MyWallet extends StatelessWidget {
  final Player player;
  const MyWallet({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                _appBar(context, player),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
Widget _appBar(
    BuildContext context,
    Player player,
    ) {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              backIcon(context),
              SizedBox(
                width: 20.w,
              ),
              Text(
                "Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorManager.white,
                  fontSize: 32.sp,
                ),
              ),
            ],
          ),
        ),
      ),
      CircleAvatar(
        radius: 50.sp,
        backgroundColor: ColorManager.grey3,
        backgroundImage: NetworkImage(player.profilePictureUrl),
      )
    ],
  );
}