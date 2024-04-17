import 'package:flutter/material.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/games/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../data/models/player.dart';

class AllPlayersScreen extends StatelessWidget {
  final List<GamePlayer> players;
  const AllPlayersScreen({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          CustomAppBar(
            height: 33.h,
            opacity: .15,
            backgroundImage: "assets/images/app_bar_backgrounds/6.webp",
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                  vertical: 7.h,
                ),
                child: Text(S.of(context).allPlayers, style: TextStyleManager.getAppBarTextStyle()),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 2.h,
              ),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    return GamePlayerItem(player: players[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  }))
        ],
      )),
    );
  }
}
