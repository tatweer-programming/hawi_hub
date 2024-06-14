import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/games/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawihub/src/modules/main/view/widgets/main_app_bar.dart';
import 'package:hawihub/src/modules/places/view/widgets/components.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/routing/routes.dart';
import '../shimmers/game_shimmers.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    GamesBloc gamesBloc = GamesBloc.get();
    return Column(
      children: [
        const MainAppBar(),
        BlocBuilder<GamesBloc, GamesState>(
          bloc: gamesBloc,
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(5.w),
              child: state is GetGamesLoading
                  ? const VerticalGamesShimmer()
                  : gamesBloc.filteredGames.isEmpty ? const EmptyView() : ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 2.h,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: gamesBloc.filteredGames.length,
                      itemBuilder: (context, index) => GameItem(game: gamesBloc.filteredGames[index]),
                    ),
            );
          },
        ),
      ],
    );
  }
}
