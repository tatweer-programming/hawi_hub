import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/games/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/main_app_bar.dart';
import 'package:hawihub/src/modules/places/view/widgets/components.dart';
import 'package:sizer/sizer.dart';

import '../shimmers/game_shimmers.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    GamesBloc gamesBloc = GamesBloc.get();
    return Column(
      children: [
        const MainAppBar(),
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
                child: state is GetGamesLoading
                    ? const VerticalGamesShimmer()
                    : gamesBloc.filteredGames.isEmpty
                        ? const EmptyView()
                        : ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              height: 2.h,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: gamesBloc.filteredGames.length,
                            itemBuilder: (context, index) =>
                                GameItem(game: gamesBloc.filteredGames[index]),
                          ),
              );
            },
          ),
        ),
      ],
    );
  }
}
