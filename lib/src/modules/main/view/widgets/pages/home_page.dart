import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/routing/routes.dart';
import 'package:hawihub/src/core/user_access_proxy/data_source_proxy.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/dummy/dummy_data.dart';
import 'package:hawihub/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawihub/src/modules/chat/view/screens/chats_screen.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/games/view/widgets/pages/play_page.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/data/models/sport.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/connectivity.dart';
import 'package:hawihub/src/modules/main/view/widgets/explore_sports_list.dart';
import 'package:hawihub/src/modules/main/view/widgets/image_widget.dart';
import 'package:hawihub/src/modules/main/view/widgets/main_app_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../main.dart';
import '../../../../../core/utils/localization_manager.dart';
import '../../../../../core/utils/styles_manager.dart';
import '../../../../games/view/widgets/components.dart';
import '../../../../places/bloc/place_bloc.dart';
import '../../../../places/view/widgets/components.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({
    Key? key,
  }) : super(key: key);

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get();
    return Column(
      children: [
        BlocBuilder<MainCubit, MainState>(
          bloc: mainCubit,
          builder: (context, state) {
            return Skeletonizer(
              enabled: state is GetBannersLoading,
              effect: const PulseEffect(),
              justifyMultiLineText: false,
              ignorePointers: false,
              ignoreContainers: false,
              containersColor: ColorManager.grey1,
              child: CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlay: true,
                  viewportFraction: .95,
                  padEnds: false,
                  pauseAutoPlayOnManualNavigate: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: state is GetBannersLoading ||
                        mainCubit.bannerList.isEmpty
                    ? dummyBanners.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Container(
                                width: 88.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList()
                    : mainCubit.bannerList.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ImageWidget(
                                i,
                                width: 88.w,
                                borderRadius: 20,
                              ),
                            );
                          },
                        );
                      }).toList(),
              ),
            );
          },
        ),

        // مؤشر الـ Carousel
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: mainCubit.bannerList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => setState(() {
                _currentIndex = entry.key;
              }),
              child: Container(
                width: _currentIndex == entry.key ? 10.0 : 8.0,
                height: _currentIndex == entry.key ? 10.0 : 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? ColorManager.golden
                      : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget heightSpacer = SizedBox(
      height: 2.h,
    );
    AuthBloc authBloc = context.read<AuthBloc>();
    UserAccessProxy(
            authBloc, GetProfileEvent(ConstantsManager.userId!, "Player"))
        .execute([AccessCheckType.login]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DefaultAppBar(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          child: ConnectionWidget(
            onRetry: retryConnecting,
            child: Column(
              children: [
                const CustomCarousel(),
                const ExploreSportsList(),
                heightSpacer,
                buildSectionTitle(
                    context, S.of(context).nearByGames, 2, mainCubit),
                buildGameList(gamesBloc),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: DefaultButton(
                    text: S.of(context).createGame,
                    onPressed: () {
                      context.push(Routes.createGame, arguments: {"id": null});
                    },
                  ),
                ),
                heightSpacer,
                buildSectionTitle(
                    context, S.of(context).nearByVenues, 1, mainCubit),
                buildPlaceList(placeBloc),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSectionTitle(
      BuildContext context, String title, int pageIndex, MainCubit mainCubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(child: TitleText(title, isBold: true)),
        TextButton(
          onPressed: () {
            mainCubit.changePage(pageIndex);
          },
          child: Row(
            children: [
              Text(S.of(context).viewAll,
                  style: TextStyleManager.getGoldenRegularStyle()),
              const Icon(Icons.arrow_forward, color: ColorManager.golden)
            ],
          ),
        ),
      ],
    );
  }

  Widget buildGameList(GamesBloc gamesBloc) {
    return SizedBox(
      height: 15.h,
      child: BlocBuilder<GamesBloc, GamesState>(
        bloc: gamesBloc,
        builder: (context, state) {
          return Skeletonizer(
            justifyMultiLineText: false,
            ignorePointers: false,
            ignoreContainers: false,
            containersColor: ColorManager.grey1,
            effect: const PulseEffect(),
            enabled: state is GetGamesLoading,
            child: gamesBloc.games.isEmpty && state is! GetGamesLoading
                ? const EmptyView()
                : ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      width: 3.w,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: state is GetGamesLoading
                        ? dummyGames.length.clamp(0, 3)
                        : gamesBloc.games.length.clamp(0, 3),
                    itemBuilder: (context, index) {
                      return GameItem(
                        game: state is GetGamesLoading
                            ? dummyGames[index]
                            : gamesBloc.games[index],
                      );
                    },
                  ),
          );
        },
      ),
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
            if (placeBloc.allPlaces.isEmpty && state is! GetAllPlacesLoading) {
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
                    enabled: state is GetAllPlacesLoading,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 3.w,
                      ),
                      itemBuilder: (context, index) => state
                              is GetAllPlacesLoading
                          ? PlaceItem(place: dummyPlaces[index])
                          : PlaceItem(place: PlaceBloc.get().allPlaces[index]),
                      itemCount: state is GetAllPlacesLoading
                          ? dummyPlaces.length
                          : placeBloc.allPlaces.length,
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

  void retryConnecting() async {
    MainCubit.get().getBanner();
    MainCubit.get().initializeHomePage();
  }

  static MainCubit mainCubit = MainCubit.get()..initializeHomePage();
  static GamesBloc gamesBloc = GamesBloc.get();
  static PlaceBloc placeBloc = PlaceBloc.get();
}

List<Sport> dummySports = [];
