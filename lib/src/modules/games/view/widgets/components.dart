import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/core/apis/api.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/routing/routes.dart';
import 'package:hawihub/src/core/user_access_proxy/data_source_proxy.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/games/data/models/game.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/data/models/sport.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/common widgets/common_widgets.dart';
import '../../../../core/utils/color_manager.dart';
import '../../data/models/player.dart';

// Game game = Game(
//     players: const [
//       GamePlayer(
//           id: 1,
//           name: "name",
//           imageUrl:
//               'https://img.freepik.com/free-psd/3d-illustration-person-with-glasses_23-2149436190.jpg?size=626&ext=jpg',
//           isHost: true),
//       GamePlayer(
//           id: 2,
//           name: "name",
//           imageUrl:
//               'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?size=626&ext=jpg'),
//       GamePlayer(
//           id: 3,
//           name: "name",
//           imageUrl:
//               'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=626&ext=jpg'),
//       GamePlayer(
//           id: 4,
//           name: "name",
//           imageUrl:
//               'https://img.freepik.com/free-psd/3d-illustration-person-with-glasses_23-2149436190.jpg?size=626&ext=jpg'),
//     ],
//     id: 1,
//     sportName: "sportName",
//     price: 200,
//     date: DateTime.now(),
//     placeId: 1,
//     maxPlayers: 8,
//     minPlayers: 3,
//     hours: 3,
//     sportImageUrl:
//         "https://img.freepik.com/premium-vector/football-balls-seamless-pattern-background_7280-4774.jpg?w=740",
//     placeAddress:
//         " placeAddress  placeAddress  placeAddress  placeAddress placeAddress  placeAddress ",
//     placeName: "placeName",
//     isPublic: true);

class GameItem extends StatelessWidget {
  final Game game;

  const GameItem({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    bool isJoined =
        game.players.any((player) => player.id == ConstantsManager.userId);
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 15.h,
      width: 85.w,
      // padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: ColorManager.grey1,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(children: [
        Expanded(
            child: InkWell(
          onTap: () {
            context.push(Routes.game, arguments: {"id": game.id});
          },
          child: Row(children: [
            Hero(
              tag: "game_${game.id}",
              child: Container(
                  width: 25.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        onError: (__, _) =>
                            ColoredBox(color: ColorManager.grey1),
                        image: NetworkImage(ApiManager.handleImageUrl(
                          MainCubit.get()
                              .sportsList
                              .firstWhere((sport) => sport.id == game.sportId,
                                  orElse: () => Sport.unKnown())
                              .image,
                        )),
                      ))),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width: 30.w,
                  height: 2.5.h,
                  decoration: const BoxDecoration(
                    color: ColorManager.golden,
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(15),
                      bottomEnd: Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "${S.of(context).only} ${game.getRemainingSlots()} ${S.of(context).slots}",
                      style: TextStyleManager.getRegularStyle(
                          color: ColorManager.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: .5.h,
                        ),
                        FittedBox(child: SubTitle(game.placeName)),
                        SizedBox(
                          height: .5.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              size: 15,
                              color: ColorManager.error,
                            ),
                            Expanded(
                              child: Text(
                                "${game.placeAddress} ",
                                style: TextStyleManager.getRegularStyle(
                                    color: ColorManager.grey2),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: .5.h,
                        ),
                        FittedBox(
                          child: Text(game.getConvertedDate(),
                              style: TextStyleManager.getRegularStyle(
                                  color: ColorManager.grey2)),
                        ),
                        SizedBox(
                          height: .5.h,
                        ),
                        FittedBox(
                          child: Text("${game.price} ${S.of(context).sar}",
                              style: TextStyleManager.getRegularStyle(
                                  color: ColorManager.secondary)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ]),
        )),
        Container(
          width: 10.w,
          color: isJoined ? ColorManager.error : ColorManager.primary,
          child: RotatedBox(
            quarterTurns: 1,
            child: JoinAndLeaveGameButton(game: game),
          ),
        )
      ]),
    );
  }
}

class GamePlayerItem extends StatelessWidget {
  final GamePlayer player;

  const GamePlayerItem({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15.h,
      width: 90.w,
      child: InkWell(
        onTap: () {
          context.push(
            Routes.profile,
            arguments: {'id': player.id, "userType": "Player"},
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 6.h,
              backgroundImage:
                  NetworkImage(ApiManager.handleImageUrl(player.imageUrl)),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitleText(player.name),
                  const SizedBox(height: 2),
                  if (player.isHost)
                    Text(
                      S.of(context).host,
                      style: TextStyleManager.getCaptionStyle(),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class JoinAndLeaveGameButton extends StatelessWidget {
  final Game game;

  const JoinAndLeaveGameButton({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    GamesBloc gamesBloc = GamesBloc.get();
    return BlocListener<GamesBloc, GamesState>(
      listener: (context, state) {
        if (state is JoinGameSuccess) {
          defaultToast(msg: S.of(context).joinedGame);
        } else if (state is LeaveGameSuccess) {
          defaultToast(msg: S.of(context).leftGame);
        } else if (state is GamesError) {
          errorToast(
              msg: ExceptionManager(state.exception).translatedMessage());
        }
      },
      child: BlocBuilder<GamesBloc, GamesState>(
          bloc: gamesBloc,
          builder: (context, state) {
            bool isJoined = game.players
                    .any((element) => element.id == ConstantsManager.userId) ||
                game.host.id == ConstantsManager.userId;

            return Container(
              decoration: BoxDecoration(
                color: isJoined ? ColorManager.error : ColorManager.primary,
              ),
              child: InkWell(
                  onTap: () {
                    if (isJoined) {
                      print(ConstantsManager.appUser!.id);
                      if (game.host.id == ConstantsManager.appUser!.id) {
                        errorToast(msg: S.of(context).cannotLeaveHost);
                      } else {
                        UserAccessProxy(
                          GamesBloc.get(),
                          LeaveGameEvent(gameId: game.id),
                        ).execute([
                          AccessCheckType.login,
                        ]);
                      }
                    } else {
                      UserAccessProxy(
                        GamesBloc.get(),
                        JoinGameEvent(gameId: game.id),
                        requiredBalance: game.price / game.minPlayers,
                        requiredAgeRange: game.getHostAge(),
                      ).execute([
                        AccessCheckType.login,
                        AccessCheckType.verification,
                        AccessCheckType.emailVerification,
                        AccessCheckType.age,
                        AccessCheckType.balance
                      ]);
                    }
                  },
                  child: BlocBuilder<GamesBloc, GamesState>(
                    bloc: GamesBloc.get(),
                    builder: (context, state) {
                      return Center(
                          child: (state is JoinGameLoading &&
                                      state.gameId == game.id) ||
                                  (state is LeaveGameLoading &&
                                      state.gameId == game.id)
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      ColorManager.white),
                                )
                              : Text(
                                  isJoined
                                      ? S.of(context).leave
                                      : S.of(context).bookNow,
                                  style: TextStyleManager.getRegularStyle(
                                      color: ColorManager.white),
                                ));
                    },
                  )),
            );
          }),
    );
  }
}
