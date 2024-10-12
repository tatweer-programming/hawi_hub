import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/dummy/dummy_data.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/games/data/models/game.dart';
import 'package:hawihub/src/modules/games/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawihub/src/modules/main/view/widgets/explore_sports_list.dart';
import 'package:hawihub/src/modules/main/view/widgets/main_app_bar.dart';
import 'package:hawihub/src/modules/places/view/widgets/components.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  Widget build(BuildContext context) {
    GamesBloc gamesBloc = GamesBloc.get();
    return SingleChildScrollView(
      child: Stack(
        children: [
          ImageAppBar(
            title: S.of(context).games,
            imagePath: "assets/images/app_bar_backgrounds/team.webp",
          ),
          Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: const ExploreSportsList(),
                    ),
                    BlocListener<GamesBloc, GamesState>(
                      listener: (context, state) {
                        if (state is JoinGameSuccess) {
                          defaultToast(msg: S.of(context).joinedGame);
                        }
                      },
                      child: BlocBuilder<GamesBloc, GamesState>(
                        bloc: gamesBloc,
                        builder: (context, state) {
                          return Padding(
                            padding: EdgeInsets.all(5.w),
                            child: Skeletonizer(
                              justifyMultiLineText: true,
                              ignorePointers: false,
                              ignoreContainers: false,
                              effect: const PulseEffect(),
                              enabled: state is GetGamesLoading,
                              child: gamesBloc.games.isEmpty &&
                                      state is! GetGamesLoading
                                  ? const EmptyView()
                                  : ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        height: 2.h,
                                      ),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: state is GetGamesLoading
                                          ? dummyGames.length
                                          : gamesBloc.games.length,
                                      itemBuilder: (context, index) => state
                                              is GetGamesLoading
                                          ? GameItem(game: dummyGames[index])
                                          : GameItem(
                                              game: gamesBloc.games[index]),
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
