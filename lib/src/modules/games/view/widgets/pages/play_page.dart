import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/games/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/routing/routes.dart';
import '../shimmers/game_shimmers.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    GamesBloc gamesBloc = GamesBloc.get()..add(GetGamesEvent());
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topCenter,
          heightFactor: 0.8,
          child: CustomAppBar(
            height: 33.h,
            opacity: .15,
            backgroundImage: "assets/images/app_bar_backgrounds/1.webp",
            actions: [
              IconButton(
                  onPressed: () {
                    context.push(Routes.notifications);
                  },
                  icon: const ImageIcon(
                    AssetImage("assets/images/icons/notification.webp"),
                    color: ColorManager.golden,
                  )),
              InkWell(
                radius: 360,
                onTap: () {
                  context.push(Routes.profile);
                },
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://img.freepik.com/free-vector/isolated-young-handsome-man-set-different-poses-white-background-illustration_632498-649.jpg?t=st=1711503056~exp=1711506656~hmac=9aea7449b3ae3f763053d68d15a49e3c70fa1e73e98311d518de5f01c2c3d41c&w=740"),
                  backgroundColor: ColorManager.golden,
                ),
              ),
            ],
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 7.h,
                child: const TextField(
                    decoration: InputDecoration(
                  hintText: "choose sport",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.expand_circle_down),
                )),
              ),
            ),
          ),
        ),
        BlocBuilder<GamesBloc, GamesState>(
          bloc: gamesBloc,
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(5.w),
              child: state is GetGamesLoading
                  ? const VerticalGamesShimmer()
                  : ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 2.h,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: gamesBloc.games.length,
                      itemBuilder: (context, index) =>
                          GameItem(game: gamesBloc.games[index]),
                    ),
            );
          },
        ),
      ],
    );
  }
}
