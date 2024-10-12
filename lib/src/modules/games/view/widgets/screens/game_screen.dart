import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/core/apis/api.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/routing/routes.dart';
import 'package:hawihub/src/core/user_access_proxy/data_source_proxy.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/games/data/models/player.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/image_widget.dart';
import 'package:hawihub/src/modules/payment/bloc/payment_cubit.dart';
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
        body: BlocListener<GamesBloc, GamesState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is JoinGameSuccess) {
          context.pop();
        } else {
          if (state is GamesError) {
            errorToast(
                msg: ExceptionManager(state.exception).translatedMessage());
          }
        }
      },
      child: BlocBuilder<GamesBloc, GamesState>(
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
                            Hero(
                              tag: "game_$id",
                              child: Container(
                                height: 50.h,
                                width: double.infinity,
                                child: ImageWidget(
                                  ApiManager.handleImageUrl(
                                    MainCubit.get()
                                        .sportsList
                                        .firstWhere(
                                            (sport) => sport.id == game.sportId,
                                            orElse: () => Sport.unKnown())
                                        .image,
                                  ),
                                  width: 100.w,
                                  height: 50.h,
                                ),
                              ),
                            ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              style: TextStyleManager
                                                  .getSecondarySubTitleStyle(),
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
                                      context.pop();
                                    },
                                    mini: true,
                                    child: const Icon(Icons.arrow_back_ios),
                                  ),
                                ))
                          ]),
                        ),
                        Padding(
                          padding: EdgeInsets.all(6.5.w),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SubTitle(
                                    "${S.of(context).players} (${game.players.length})"),
                                SizedBox(height: 2.h),
                                _buildHost(context, game.host),
                                SizedBox(height: 2.h),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                            width: 50.w,
                                            height: 6.h,
                                            child: Stack(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                children: [
                                                  game.host,
                                                  ...game.players
                                                ]
                                                    .sublist(
                                                        0,
                                                        game.players.length > 3
                                                            ? 3
                                                            : game
                                                                .players.length)
                                                    .map((e) =>
                                                        PositionedDirectional(
                                                          start: (game.players
                                                                      .indexOf(
                                                                          e) +
                                                                  1) *
                                                              5.w,
                                                          child: CircleAvatar(
                                                            radius: 3.h,
                                                            backgroundImage:
                                                                NetworkImage(ApiManager
                                                                    .handleImageUrl(
                                                                        e.imageUrl)),
                                                          ),
                                                        ))
                                                    .toList())),
                                      ),
                                      if (game.players.isNotEmpty)
                                        TextButton(
                                          onPressed: () {
                                            context.push(Routes.allPlayers,
                                                arguments: {
                                                  "players": [
                                                    game.host,
                                                    ...game.players
                                                  ]
                                                });
                                          },
                                          child: Row(
                                            children: [
                                              if (game.players.isNotEmpty)
                                                Text(
                                                  S.of(context).viewAll,
                                                ),
                                              const Icon(Icons.chevron_right)
                                            ],
                                          ),
                                        )
                                    ]),
                                SizedBox(height: 2.h),
                                SubTitle(S.of(context).sport),
                                SizedBox(
                                  height: 2.h,
                                ),
                                SportNameWidget(
                                  sport: MainCubit.get()
                                      .sportsList
                                      .firstWhere(
                                          (sport) => sport.id == game.sportId,
                                          orElse: () => Sport.unKnown())
                                      .name,
                                  sportId: MainCubit.get()
                                      .sportsList
                                      .firstWhere(
                                          (sport) => sport.id == game.sportId,
                                          orElse: () => Sport.unKnown())
                                      .id,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                SubTitle(
                                    "${S.of(context).hours} : ${game.hours}"),
                                SizedBox(
                                  height: 2.h,
                                ),
                                SubTitle("${S.of(context).youWillPay}: "
                                    "${game.getPriceAverage()} ${S.of(context).sar}"),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<PaymentCubit, PaymentState>(
                  builder: (context, state) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      child: DefaultButton(
                        isLoading: state is JoinGameLoading,
                        text: S.of(context).join,
                        onPressed: () {
                          if (ConstantsManager.userId == null) {
                            errorToast(msg: S.of(context).loginFirst);
                          } else {
                            bool isJoined = game.players.any((element) =>
                                    element.id == ConstantsManager.userId) ||
                                game.host.id == ConstantsManager.userId;
                            if (isJoined) {
                              defaultToast(msg: S.of(context).alreadyJoined);
                            } else {
                              UserAccessProxy(
                                bloc,
                                JoinGameEvent(gameId: game.id),
                                requiredBalance: game.price / game.minPlayers,
                                requiredAgeRange: game.getHostAge(),
                              ).execute([
                                AccessCheckType.login,
                                AccessCheckType.verification,
                                AccessCheckType.age,
                                AccessCheckType.balance
                              ]);
                              // PaymentCubit paymentCubit = PaymentCubit.get();
                              // paymentCubit.joinToGame(game.price);
                            }
                          }
                        },
                        height: 6.h,
                      ),
                    );
                  },
                )
              ],
            );
          }),
    ));
  }

  Widget _buildHost(BuildContext context, GamePlayer player) {
    return SizedBox(
      height: 6.h,
      child: InkWell(
        onTap: () {
          context.push(
            Routes.profile,
            arguments: {'id': player.id, "userType": "Player"},
          );
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 3.h,
              backgroundImage:
                  NetworkImage(ApiManager.handleImageUrl(player.imageUrl)),
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
}
