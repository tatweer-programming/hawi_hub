import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/core/apis/api.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/routing/routes.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/games/data/models/player.dart';
import 'package:hawihub/src/modules/games/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../main/cubit/main_cubit.dart';
import '../../../../main/data/models/sport.dart';
import '../../../data/models/game.dart';

class GameDetailsScreen extends StatelessWidget {
  final int id;

  const GameDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    GamesBloc bloc = GamesBloc.get()..add(GetGameEvent(id));
    Game game = bloc.games.firstWhere((e) => e.id == id);
    return Scaffold(
        body: BlocBuilder<GamesBloc, GamesState>(
            bloc: bloc,
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50.h,
                            child: Stack(children: [
                              Container(
                                  height: 50.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              ApiManager.handleImageUrl(
                                                MainCubit.get().sportsList.firstWhere((sport) => sport.id == game.sportId  ,orElse: () => Sport.unKnown()).image, ),
                                          )))),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 12.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                      color: ColorManager.white.withOpacity(.7),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  child: Padding(
                                    padding: EdgeInsets.all(3.w),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Row(children: [
                                            Expanded(
                                              child: TitleText(
                                                game.placeName,
                                              ),
                                            ),
                                            FittedBox(
                                              child: Text(
                                                "${S.of(context).price} : ${game.price}${S.of(context).sar}",
                                                style: TextStyleManager.getSecondarySubTitleStyle(),
                                              ),
                                            ),
                                          ])),
                                          Expanded(
                                              child: Row(children: [
                                            Expanded(
                                              child: Text(
                                                game.placeAddress,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            FittedBox(
                                              child: Column(
                                                children: [
                                                  Text(game.getConvertedDate()),
                                                  SizedBox(height: .5.h),
                                                  Text(
                                                      "${S.of(context).only} ${game.getRemainingSlots()} ${S.of(context).slots}"),
                                                ],
                                              ),
                                            ),
                                          ])),
                                        ]),
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5.h,
                                      horizontal: 4.w,
                                    ),
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      mini: true,
                                      child: const Icon(Icons.arrow_back_ios),
                                    ),
                                  ))
                            ]),
                          ),

                          /// players section
                          Padding(
                            padding: EdgeInsets.all(6.5.w),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              SubTitle("${S.of(context).players} (${game.players.length})"),
                              SizedBox(height: 2.h),
                              _buildHost(
                                  context, game.host),
                              SizedBox(height: 2.h),
                              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                SizedBox(
                                    width: 30.w,
                                    height: 6.h,
                                    child: Stack(
                                        alignment: AlignmentDirectional.centerStart,
                                        children: [
                                          game.host ,
                                          ...game.players
                                        ].sublist(0,
                                                game.players.length > 3 ? 3 : game.players.length)
                                            .map((e) => Positioned(
                                                  left: game.players.indexOf(e) * 7.w,
                                                  child: CircleAvatar(
                                                    radius: 3.h,
                                                    backgroundImage: NetworkImage( ApiManager.handleImageUrl(e.imageUrl)),
                                                  ),
                                                ))
                                            .toList())),
                                TextButton(
                                  onPressed: () {
                                    context.push(Routes.allPlayers,
                                        arguments: {"players": [
                                          game.host ,
                                          ...game.players
                                        ]});
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        S.of(context).viewAll,
                                      ),
                                      const Icon(Icons.chevron_right)
                                    ],
                                  ),
                                )
                              ]),
                              SizedBox(height: 4.h),
                              SubTitle(S.of(context).sport),
                              SizedBox(
                                height: 2.h,
                              ),
                              _buildSportWidget(MainCubit.get().sportsList.firstWhere((sport) => sport.id == game.sportId  ,orElse: () => Sport.unKnown()).name, context),
                              SizedBox(
                                height: 2.h,
                              ),
                              SubTitle("${S.of(context).hours} : ${game.hours}"),

                              // SizedBox(height: 2.h,),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child: DefaultButton(
                      isLoading: state is JoinGameLoading,
                      text: S.of(context).join,
                      onPressed: () {
                        bloc.add(JoinGameEvent(gameId: game.id));
                      },
                      height: 6.h,
                    ),
                  )
                ],
              );
            }));
  }

  Widget _buildHost(context, GamePlayer player) {
    return SizedBox(
      height: 6.h,
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            CircleAvatar(
              radius: 3.h,
              backgroundImage: NetworkImage(ApiManager.handleImageUrl(player.imageUrl)),
            ),
            SizedBox(width: 2.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SubTitle(player.name),
                const SizedBox(height: 2),
                Text(
                  S.of(context).host,
                  style: TextStyleManager.getCaptionStyle(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSportWidget(String sport, BuildContext context) {
    return Container(
      height: 5.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.grey1,
      ),
      child: InkWell(
          onTap: () {
            // TODO navigate to sport Screen
          },
          child: Center(child: Text(sport, style: TextStyleManager.getBlackCaptionTextStyle()))),
    );
  }
}
