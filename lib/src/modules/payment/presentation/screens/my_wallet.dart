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
            child: _appBar(context, player),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            player.userName,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "My Wallet",
                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                _walletWidget( player.myWallet.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _appBar(BuildContext context, Player player) {
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
            children: [
              backIcon(context),
              SizedBox(
                width: 20.w,
              ),
              Text(
                "Wallet",
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

Widget _walletWidget(String wallet) {
  return Container(
    height: 5.h,
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xff757575),
      borderRadius: BorderRadius.circular(25.sp),
    ),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: 5.w,
            top: 1.h,
            bottom: 1.h,
          ),
          child: Text(
            "$wallet \$",
            style: const TextStyle(
              color: ColorManager.white,
            ),
          ),
        ),
      ],
    ),
  );
}
