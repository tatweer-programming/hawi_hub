import 'package:flutter/material.dart';
import 'package:hawihub/src/modules/games/data/models/game.dart';
import 'package:sizer/sizer.dart';

class GameItem extends StatelessWidget {
  final Game game;

  const GameItem({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(360),
          bottomRight: Radius.circular(360),
        ),
      ),
    );
  }
}
