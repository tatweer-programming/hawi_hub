import 'package:flutter/material.dart';
import 'package:hawihub/src/modules/games/data/models/game.dart';

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
    return Center(
        // child: GameItem(game: game),
        );
  }
}
