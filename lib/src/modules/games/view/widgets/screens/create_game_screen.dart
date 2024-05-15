import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/games/data/models/game.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
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
    GlobalKey formKey = GlobalKey<FormState>();
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
                      backgroundImage: "assets/images/app_bar_backgrounds/5.webp",
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
                                text: S.of(context).sport, onChanged: (value) {}, items: []),
                            SizedBox(
                              height: 3.h,
                            ),
                            dropdownBuilder(
                                text: S.of(context).place, onChanged: (value) {}, items: []),
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
                                              height: 9.h, radius: 30, child: const SizedBox())),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          width: 30.w,
                                          color: ColorManager.white,
                                          child: Text(
                                            S.of(context).accessibility,
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
                                              height: 9.h,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.w, vertical: 1.h),
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
                                                                isPublic: true));
                                                      },
                                                      radius: 36,
                                                      child: Text(
                                                        S.of(context).public,
                                                        style: TextStyleManager.getRegularStyle(
                                                            color: bloc.isPublic
                                                                ? ColorManager.white
                                                                : ColorManager.black),
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
                                                          : ColorManager.primary,
                                                      color: bloc.isPublic
                                                          ? null
                                                          : ColorManager.primary,
                                                      onPressed: () {
                                                        GamesBloc.get().add(
                                                            const ChangeGameAccessEvent(
                                                                isPublic: false));
                                                      },
                                                      radius: 36,
                                                      child: Text(
                                                        S.of(context).private,
                                                        style: TextStyleManager.getRegularStyle(
                                                            color: bloc.isPublic
                                                                ? ColorManager.black
                                                                : ColorManager.white),
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
                                radius: 30, height: 7.h, child: Text(S.of(context).date)),
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
                                          height: 9.h, radius: 36, child: const SizedBox())),
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
                                                    controller: minPlayersController,
                                                    keyboardType: TextInputType.number,
                                                    decoration: InputDecoration(
                                                      hintText: S.of(context).minPlayers,
                                                    )),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                    controller: maxPlayersController,
                                                    keyboardType: TextInputType.number,
                                                    decoration: InputDecoration(
                                                      hintText: S.of(context).maxPlayers,
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
                return DefaultButton(
                    isLoading: state is CreateGameLoading,
                    text: S.of(context).createGame,
                    onPressed: () {
                      bloc.add(CreateGameEvent(
                        minPlayers: int.parse(minPlayersController.text),
                        maxPlayers: int.parse(maxPlayersController.text),
                      ));
                      // context.push(Routes.bookNow, arguments: {"id": cubit.currentPlace!.id});
                      debugPrint("Book Now");
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
