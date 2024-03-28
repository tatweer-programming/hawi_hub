import 'package:flutter/material.dart';
import 'package:hawihub/src/modules/games/data/models/game.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

import '../shimmers/game_shimmers.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    Game game = Game(
        id: 1,
        sportName: "sportName",
        price: 200,
        date: DateTime.now(),
        placeId: 1,
        maxPlayers: 5,
        minPlayers: 3,
        hours: 3,
        sportImageUrl: "",
        placeAddress: "",
        placeName: "",
        isPublic: true);
    return Column(
      children: [
        CustomAppBar(
          //color:  ,
          opacity: .1,
          // blendMode: BlendMode.saturation,
          backgroundImage: "assets/images/app_bar_backgrounds/6.webp",
          height: 35.h,
          actions: const [
            //   Icon(Icons.notifications),
          ],
          child: const Text(
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            "",
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.w),
          child: const VerticalGamesShimmer(),
        ),
      ],
    );
  }
}
