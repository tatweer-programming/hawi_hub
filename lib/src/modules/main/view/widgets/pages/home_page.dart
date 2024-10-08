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
import 'package:hawihub/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawihub/src/modules/chat/view/screens/chats_screen.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/connectivity.dart';
import 'package:hawihub/src/modules/main/view/widgets/main_app_bar.dart';
import 'package:hawihub/src/modules/main/view/widgets/shimmers/banner_shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../main.dart';
import '../../../../../core/utils/localization_manager.dart';
import '../../../../../core/utils/styles_manager.dart';
import '../../../../games/view/widgets/components.dart';
import '../../../../games/view/widgets/shimmers/game_shimmers.dart';
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
            return CarouselSlider(
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
              items: mainCubit.bannerList.isEmpty
                  ? [const BannersShimmer()]
                  : mainCubit.bannerList.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: 88.w,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ColorManager.shimmerBaseColor,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(i),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
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
        SafeArea(
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    context.pushWithTransition(const ChatsScreen());
                  },
                  icon: const ImageIcon(
                    AssetImage("assets/images/icons/chat.png"),
                    color: ColorManager.golden,
                  )),
              InkWell(
                radius: 360,
                onTap: () {
                  context.push(
                    Routes.profile,
                    arguments: {
                      'id': ConstantsManager.userId,
                      "userType": "Player"
                    },
                  );
                },
                child: CircleAvatar(
                  backgroundColor: ColorManager.grey3,
                  backgroundImage: ConstantsManager.appUser != null &&
                          ConstantsManager.appUser!.profilePictureUrl != null
                      ? NetworkImage(
                          ConstantsManager.appUser!.profilePictureUrl!)
                      : const AssetImage("assets/images/icons/user.png")
                          as ImageProvider<Object>,
                ),
              ),
              IconButton(
                  onPressed: () {
                    context.push(Routes.notifications);
                  },
                  icon: const ImageIcon(
                    AssetImage("assets/images/icons/notification.webp"),
                    color: ColorManager.golden,
                  )),
              const Spacer(),
              BlocBuilder<MainCubit, MainState>(
                bloc: mainCubit,
                builder: (context, state) {
                  return CityDropdown(
                      selectedCity: mainCubit.currentCityId == null
                          ? S.of(context).chooseSport
                          : LocalizationManager
                              .getSaudiCities[mainCubit.currentCityId! - 1],
                      onCitySelected: (c) async {
                        await mainCubit.selectCity(c);
                      },
                      cities: LocalizationManager.getSaudiCities);
                },
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          child: ConnectionWidget(
            onRetry: retryConnecting,
            child: Column(
              children: [
                const CustomCarousel(),
                heightSpacer,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: TitleText(S.of(context).exploreBySports,
                            isBold: true)),
                    const SizedBox(),
                  ],
                ),
                heightSpacer,
                buildSportsList(mainCubit),
                heightSpacer,
                buildSectionTitle(
                    context, S.of(context).nearByGames, 1, mainCubit),
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
                    context, S.of(context).nearByVenues, 2, mainCubit),
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
          if (state is GetGamesLoading) {
            return const HorizontalGamesShimmer();
          } else if (gamesBloc.filteredGames.isEmpty) {
            return const EmptyView();
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                width: 3.w,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: gamesBloc.filteredGames.length.clamp(0, 3),
              itemBuilder: (context, index) {
                return GameItem(game: gamesBloc.filteredGames[index]);
              },
            );
          }
        },
      ),
    );
  }

  Widget buildSportsList(MainCubit mainCubit) {
    return SizedBox(
      height: 15.h,
      child: BlocBuilder<MainCubit, MainState>(
        bloc: mainCubit,
        builder: (context, state) {
          if (mainCubit.sportsList.isEmpty) {
            return const EmptyView();
          } else {
            return Skeletonizer(
                enabled: state is GetSportsLoading,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    width: 3.w,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: mainCubit.sportsList.length,
                  itemBuilder: (context, index) {
                    return SportItemWidget(sport: mainCubit.sportsList[index]);
                  },
                ));
          }
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
            if (placeBloc.viewedPlaces.isEmpty &&
                state is! GetAllPlacesLoading) {
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
                      itemBuilder: (context, index) =>
                          state is GetAllPlacesLoading
                              ? PlaceItem(place: dummyPlaces[index])
                              : PlaceItem(
                                  place: PlaceBloc.get().viewedPlaces[index]),
                      itemCount: state is GetAllPlacesLoading
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

  void retryConnecting() async {
    MainCubit.get().getBanner();
    MainCubit.get().initializeHomePage();
  }

  static MainCubit mainCubit = MainCubit.get()..initializeHomePage();
  static GamesBloc gamesBloc = GamesBloc.get();
  static PlaceBloc placeBloc = PlaceBloc.get();
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
