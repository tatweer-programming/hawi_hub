import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/core/apis/api.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/error/remote_error.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/routing/routes.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/connectivity.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawihub/src/modules/main/view/widgets/main_app_bar.dart';
import 'package:hawihub/src/modules/main/view/widgets/shimmers/banner_shimmer.dart';
import 'package:hawihub/src/modules/places/view/widgets/shimmers/place_shimmers.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../core/utils/styles_manager.dart';
import '../../../../games/view/widgets/components.dart';
import '../../../../games/view/widgets/shimmers/game_shimmers.dart';
import '../../../../places/bloc/place__bloc.dart';
import '../../../../places/view/widgets/components.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get()..initializeHomePage();
    GamesBloc gamesBloc = GamesBloc.get();
    PlaceBloc placeBloc = PlaceBloc.get();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainAppBar(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          child: ConnectionWidget(
              onRetry: retryConnecting,
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.h,
                  ),
                  child: DefaultButton(
                    text: S.of(context).createGame,
                    onPressed: () {
                      context.push(Routes.createGame);
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                  width: 90.w,
                  child: BlocBuilder<MainCubit, MainState>(
                    bloc: mainCubit,
                    builder: (context, state) {
                      return CarouselSlider(
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlay: true,
                          pauseAutoPlayInFiniteScroll: true,
                          pauseAutoPlayOnTouch: true,
                          // aspectRatio: 90.w / 30.h,
                          viewportFraction: 0.87,
                          padEnds: false,
                          pauseAutoPlayOnManualNavigate: true,
                        ),
                        items: mainCubit.bannerList.isEmpty
                            ? [const BannersShimmer()]
                            : mainCubit.bannerList.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: 88.w,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: ColorManager.shimmerBaseColor,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(i),
                                          )),
                                    );
                                  },
                                );
                              }).toList(),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child:
                            TitleText(S.of(context).nearByGames, isBold: true)),
                    TextButton(
                        onPressed: () {
                          mainCubit.changePage(1);
                        },
                        child: Row(
                          children: [
                            Text(S.of(context).viewAll,
                                style:
                                    TextStyleManager.getGoldenRegularStyle()),
                            const Icon(Icons.arrow_forward,
                                color: ColorManager.golden)
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 15.h,
                  child: BlocBuilder<GamesBloc, GamesState>(
                      bloc: gamesBloc,
                      builder: (context, state) {
                        print(state);
                        return state is GetGamesLoading
                            ? const HorizontalGamesShimmer()
                            : gamesBloc.filteredGames.isEmpty
                                ? const EmptyView()
                                : ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => GameItem(
                                        game: gamesBloc.filteredGames[index]),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                    itemCount:
                                        gamesBloc.filteredGames.length > 3
                                            ? 3
                                            : gamesBloc.filteredGames.length);
                      }),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: TitleText(S.of(context).nearByVenues,
                            isBold: true)),
                    TextButton(
                        onPressed: () {
                          mainCubit.changePage(2);
                        },
                        child: Row(
                          children: [
                            Text(S.of(context).viewAll,
                                style:
                                    TextStyleManager.getGoldenRegularStyle()),
                            const Icon(Icons.arrow_forward,
                                color: ColorManager.golden)
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 27.h,
                  child: BlocListener<PlaceBloc, PlaceState>(
                    bloc: placeBloc,
                    listener: (context, state) {
                      if (state is PlaceError) {
                        errorToast(
                            msg: ExceptionManager(state.exception)
                                .translatedMessage());
                      }
                    },
                    child: BlocBuilder<PlaceBloc, PlaceState>(
                        bloc: placeBloc,
                        builder: (context, state) {
                          return state is GetAllPlacesLoading
                              ? const HorizontalPlacesShimmer()
                              : placeBloc.viewedPlaces.isEmpty
                                  ? const EmptyView()
                                  : ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          PlaceItem(
                                            place:
                                                placeBloc.viewedPlaces[index],
                                          ),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                      itemCount:
                                          placeBloc.viewedPlaces.length > 3
                                              ? 3
                                              : placeBloc.viewedPlaces.length);
                        }),
                  ),
                ),
              ])),
        ),
      ],
    );
  }

  void retryConnecting() async {
    MainCubit.get().getBanner();
  }
}

// Place place = Place(
//   latitudes: "",
//   longitudes: "",
//   totalGames: 122,
//   totalRatings: 90,
//   rating: 3.5,
//   address:
//       "place address place address place address place address place address place address place address place address",
//   ownerId: 1,
//   name: "Place name",
//   description:
//       "place place place place place place place place place place place place place place place place place place place place place place place place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description ",
//   images: const [
//     "https://www.sofistadium.com/assets/img/SoFiStadium_bowl-9f3e09bf67.jpg",
//     "https://www.accoes.com/wp-content/uploads/2022/08/IMG_5382-scaled.jpg",
//     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9E2ITnbivkVxMi2refJT2OUZb4SaCOZJJeIvMjUwgWCiHoFLnKUOU7m1a4wz1Lp9_Hzo&usqp=CAU",
//   ],
//   id: 1,
//   ownerImageUrl: '',
//   ownerName: 'owner name',
//   sport: 'Football',
//   price: 0,
//   minimumHours: 0,
//   completedDays: const [],
//   feedbacks: const [],
// );
