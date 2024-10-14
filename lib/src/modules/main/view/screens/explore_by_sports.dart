import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/main.dart';
import 'package:hawihub/src/core/apis/api.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/routing/routes.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/dummy/dummy_data.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/games/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/data/models/sport.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/image_widget.dart';
import 'package:hawihub/src/modules/places/bloc/place_bloc.dart';
import 'package:hawihub/src/modules/places/view/widgets/components.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExploreBySportsScreen extends StatefulWidget {
  final int sportId;

  const ExploreBySportsScreen({super.key, required this.sportId});

  @override
  State<ExploreBySportsScreen> createState() => _ExploreBySportsScreenState();
}

class _ExploreBySportsScreenState extends State<ExploreBySportsScreen> {
  MainCubit cubit = MainCubit.get();
  late Sport sport;

  @override
  void initState() {
    sport = cubit.sportsList.firstWhere((e) => e.id == widget.sportId);
    cubit.selectSport(sport.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(children: [
            SizedBox(
              height: 30.h,
              width: 90.w,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: "sport_${widget.sportId}",
                      child: SafeArea(
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: ColorManager.grey1,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: ImageWidget(
                                    ApiManager.handleImageUrl(sport.image)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const PrimaryBackButton()
                ],
              ),
            ),
            SizedBox(height: 4.h),
            buildSectionTitle(
                context, "${sport.name} ${S.of(context).games}", 1, cubit),
            SizedBox(height: 1.h),
            buildGameList(GamesBloc.get()),
            SizedBox(height: 4.h),
            buildSectionTitle(
                context, "${sport.name} ${S.of(context).venues}", 2, cubit),
            SizedBox(height: 1.h),
            buildPlaceList(PlaceBloc.get()),
          ]),
        ),
      ),
    );
  }

  Widget buildGameList(GamesBloc gamesBloc) {
    return SizedBox(
      height: 15.h,
      child: BlocBuilder<GamesBloc, GamesState>(
        bloc: gamesBloc,
        builder: (context, state) {
          return Skeletonizer(
            enabled: state is SelectGamesSportLoading,
            effect: const PulseEffect(),
            child: gamesBloc.filteredGames.isEmpty
                ? const EmptyView()
                : ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      width: 3.w,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: state is SelectGamesSportLoading
                        ? dummyGames.length
                        : gamesBloc.filteredGames.length,
                    itemBuilder: (context, index) {
                      return state is SelectGamesSportLoading
                          ? GameItem(game: dummyGames[index])
                          : GameItem(game: gamesBloc.filteredGames[index]);
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget buildSectionTitle(
      BuildContext context, String title, int pageIndex, MainCubit mainCubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(child: TitleText(title, isBold: true)),
        SizedBox(),
      ],
    );
  }

  Widget buildPlaceList(PlaceBloc placeBloc) {
    return SizedBox(
      height: 45.h,
      child: BlocListener<PlaceBloc, PlaceState>(
        bloc: placeBloc,
        listener: (context, state) {
          if (state is PlaceError) {
            errorToast(
                msg: ExceptionManager(state.exception).translatedMessage());
          }
        },
        child: BlocBuilder<PlaceBloc, PlaceState>(
          bloc: placeBloc,
          builder: (context, state) {
            if (placeBloc.viewedPlaces.isEmpty &&
                state is! SelectPlacesSportLoading) {
              return const EmptyView();
            } else {
              return BlocBuilder<PlaceBloc, PlaceState>(
                bloc: placeBloc,
                builder: (context, state) {
                  return Skeletonizer(
                    justifyMultiLineText: true,
                    ignorePointers: false,
                    ignoreContainers: false,
                    effect: const PulseEffect(),
                    enabled: state is SelectPlacesSportLoading,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 3.w,
                      ),
                      itemBuilder: (context, index) =>
                          state is SelectPlacesSportLoading
                              ? PlaceItem(place: dummyPlaces[index])
                              : PlaceItem(
                                  place: PlaceBloc.get().viewedPlaces[index]),
                      itemCount: state is SelectPlacesSportLoading
                          ? dummyPlaces.length
                          : placeBloc.viewedPlaces.length,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
/*
TODO: get upcoming games and reservations
TODO: edit main screen UI
TODO: complete genders functionality
TODO: Skeletonizer for places , games adn sports
 */
