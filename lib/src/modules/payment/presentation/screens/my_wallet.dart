import 'package:flutter/material.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/modules/auth/data/models/player.dart';
import 'package:hawihub/src/modules/auth/view/widgets/auth_app_bar.dart';
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
            child: AuthAppBar(
              player: player,
              context: context,
              title: S.of(context).myWallet,
            ),
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
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                if (ConstantsManager.userId == player.id)
                  walletWidget(() {}, player.myWallet.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
