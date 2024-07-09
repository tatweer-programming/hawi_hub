import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/apis/api.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/routing/routes.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawihub/src/modules/places/bloc/place_bloc.dart';
import 'package:hawihub/src/modules/places/data/proxy/data_source_proxy.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

class CreateGameScreen extends StatelessWidget {
  const CreateGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // sport
    // date
    // place , min players , max players ,  accessibility
    TextEditingController minPlayersController = TextEditingController();
    TextEditingController maxPlayersController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    GamesBloc bloc = GamesBloc.get();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(children: [
                    CustomAppBar(
                      actions: [
                        SizedBox(
                          height: 5.h,
                        )
                      ],
                      height: 33.h,
                      opacity: .15,
                      backgroundImage:
                          "assets/images/app_bar_backgrounds/5.webp",
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                        ),
                        child: SizedBox(
                          height: 7.h,
                          child: Text(
                            S.of(context).createGame,
                            style: TextStyleManager.getAppBarTextStyle(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          children: [
                            dropdownBuilder(
                              text: S.of(context).chooseSport,
                              images: [
                                ...MainCubit.get()
                                    .sportsList
                                    .map((e) => e.image)
                              ],
                              onChanged: (val) {
                                MainCubit.get().selectSport(val!);
                              },
                              items: MainCubit.get()
                                  .sportsList
                                  .map((e) => e.name)
                                  .toList(),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            dropdownBuilder(
                              images: PlaceBloc.get()
                                  .viewedPlaces
                                  .map((e) => e.images.first)
                                  .toList(),
                              text: S.of(context).place,
                              onChanged: (value) {
                                bloc.selectedStadiumId = PlaceBloc.get()
                                    .viewedPlaces
                                    .firstWhere((e) => e.name == value)
                                    .id;
                              },
                              items: PlaceBloc.get()
                                  .viewedPlaces
                                  .map((e) => e.name)
                                  .toList(),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            BlocBuilder<GamesBloc, GamesState>(
                              builder: (context, state) {
                                return SizedBox(
                                  height: 10.h,
                                  child: Stack(
                                    children: [
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: OutLineContainer(
                                              height: 9.h,
                                              radius: 30,
                                              child: const SizedBox())),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          width: 30.w,
                                          color: ColorManager.white,
                                          child: Text(
                                            S.of(context).accessibility,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                backgroundColor:
                                                    ColorManager.white,
                                                color: ColorManager.primary),
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: SizedBox(
                                              height: 9.h,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.w,
                                                    vertical: 1.h),
                                                child: Row(children: [
                                                  Expanded(
                                                    child: OutLineContainer(
                                                      borderColor: bloc.isPublic
                                                          ? ColorManager.primary
                                                          : null,
                                                      color: bloc.isPublic
                                                          ? ColorManager.primary
                                                          : null,
                                                      onPressed: () {
                                                        GamesBloc.get().add(
                                                            const ChangeGameAccessEvent(
                                                                isPublic:
                                                                    true));
                                                      },
                                                      radius: 36,
                                                      child: Text(
                                                        S.of(context).public,
                                                        style: TextStyleManager
                                                            .getRegularStyle(
                                                                color: bloc
                                                                        .isPublic
                                                                    ? ColorManager
                                                                        .white
                                                                    : ColorManager
                                                                        .black),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  Expanded(
                                                    child: OutLineContainer(
                                                      borderColor: bloc.isPublic
                                                          ? null
                                                          : ColorManager
                                                              .primary,
                                                      color: bloc.isPublic
                                                          ? null
                                                          : ColorManager
                                                              .primary,
                                                      onPressed: () {
                                                        GamesBloc.get().add(
                                                            const ChangeGameAccessEvent(
                                                                isPublic:
                                                                    false));
                                                      },
                                                      radius: 36,
                                                      child: Text(
                                                        S.of(context).private,
                                                        style: TextStyleManager
                                                            .getRegularStyle(
                                                                color: bloc
                                                                        .isPublic
                                                                    ? ColorManager
                                                                        .black
                                                                    : ColorManager
                                                                        .white),
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                              ))),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            OutLineContainer(
                                onPressed: () {
                                  if (bloc.selectedStadiumId == null) {
                                    errorToast(
                                        msg: S.of(context).chooseStadium);
                                  } else {
                                    context.push(Routes.selectGameTime,
                                        arguments: {
                                          "id": bloc.selectedStadiumId
                                        });
                                  }
                                },
                                radius: 30,
                                height: 7.h,
                                child: Text(S.of(context).date)),
                            SizedBox(
                              height: 3.h,
                            ),
                            SizedBox(
                              height: 10.h,
                              child: Stack(
                                children: [
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: OutLineContainer(
                                          height: 9.h,
                                          radius: 36,
                                          child: const SizedBox())),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      width: 30.w,
                                      color: ColorManager.white,
                                      child: Text(
                                        S.of(context).players,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            backgroundColor: ColorManager.white,
                                            color: ColorManager.primary),
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SizedBox(
                                          height: 8.h,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w, vertical: 1.h),
                                            child: Row(children: [
                                              Expanded(
                                                child: TextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty ||
                                                          int.tryParse(value) ==
                                                              null) {
                                                        return S
                                                            .of(context)
                                                            .maxPlayersRequired;
                                                      }
                                                      return null;
                                                    },
                                                    controller:
                                                        minPlayersController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      hintText: S
                                                          .of(context)
                                                          .minPlayers,
                                                    )),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                    controller:
                                                        maxPlayersController,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty ||
                                                          int.tryParse(value) ==
                                                              null) {
                                                        return S
                                                            .of(context)
                                                            .maxPlayersRequired;
                                                      }
                                                      return null;
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      hintText: S
                                                          .of(context)
                                                          .maxPlayers,
                                                    )),
                                              )
                                            ]),
                                          ))),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                          ],
                        )),
                  ])),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: BlocBuilder<GamesBloc, GamesState>(
              bloc: bloc,
              builder: (context, state) {
                return BlocListener<GamesBloc, GamesState>(
                  listener: (context, state) {
                    if (state is CreateGameSuccess) {
                      Uri uri = Uri.parse(
                          "${ApiManager.domain}game/?id=${state.gameId}");
                      _showBookingDialog(context, uri.toString());
                    } else if (state is GamesError) {
                      errorToast(
                          msg: ExceptionManager(state.exception)
                              .translatedMessage());
                    }
                  },
                  child: DefaultButton(
                      isLoading: state is CreateGameLoading,
                      text: S.of(context).createGame,
                      onPressed: () {
                        if (formKey.currentState!.validate() &&
                            bloc.selectedStadiumId != null &&
                            bloc.booking != null) {
                          UserAccessProxy(
                              bloc,
                              CreateGameEvent(
                                minPlayers:
                                    int.parse(minPlayersController.text),
                                maxPlayers:
                                    int.parse(maxPlayersController.text),
                              )).execute(
                            [
                              AccessCheckType.login,
                              AccessCheckType.balance,
                              AccessCheckType.verification,
                              AccessCheckType.age
                            ],
                          );
                        } else {
                          if (bloc.selectedStadiumId == null) {
                            errorToast(msg: S.of(context).chooseStadium);
                          } else if (bloc.booking == null) {
                            errorToast(msg: S.of(context).chooseDate);
                          }
                        }
                        // context.push(Routes.bookNow, arguments: {"id": cubit.currentPlace!.id});
                        debugPrint("Book Now");
                      }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showBookingDialog(BuildContext ctx, String link) {
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).gameCreated),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onLongPress: () {
                  Clipboard.setData(ClipboardData(text: link));
                },
                child: TextField(
                  controller: TextEditingController(text: link),
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        Share.share(link);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
