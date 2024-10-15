import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/dummy/dummy_data.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/games/data/models/game.dart';
import 'package:hawihub/src/modules/games/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/places/view/widgets/components.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UpComingGamesList extends StatelessWidget {
  const UpComingGamesList({super.key});

  @override
  Widget build(BuildContext context) {
    GamesBloc gamesBloc = GamesBloc.get();

    return BlocConsumer<GamesBloc, GamesState>(
      listener: (context, state) {
        if (state is GetUpcomingGamesSuccess) {
          debugPrint(state.games.toString());
        }
      },
      builder: (context, state) {
        return Skeletonizer(
          justifyMultiLineText: true,
          enableSwitchAnimation: true,
          ignorePointers: false,
          ignoreContainers: false,
          containersColor: ColorManager.grey1,
          effect: const PulseEffect(),
          enabled: state is GetUpcomingGamesLoading,
          child: gamesBloc.upcomingGames.isEmpty &&
                  state is! GetUpcomingGamesLoading
              ? const EmptyView()
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 2.h,
                  ),
                  itemCount: state is GetUpcomingGamesLoading
                      ? dummyGames.length.clamp(0, 3)
                      : gamesBloc.upcomingGames.length,
                  itemBuilder: (context, index) {
                    return GameItem(
                      game: state is GetUpcomingGamesLoading
                          ? dummyGames[index]
                          : gamesBloc.upcomingGames[index],
                    );
                  },
                ),
        );
      },
    );
    ;
  }
}
