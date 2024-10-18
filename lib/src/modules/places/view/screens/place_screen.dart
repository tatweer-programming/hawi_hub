import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawihub/src/core/apis/api.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/core/utils/font_manager.dart';
import 'package:hawihub/src/core/utils/localization_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/auth/view/screens/add_feedback_for_club.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/data/models/sport.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawihub/src/modules/places/bloc/place_bloc.dart';
import 'package:hawihub/src/modules/places/data/models/day.dart';
import 'package:hawihub/src/modules/places/data/models/place.dart';
import 'package:hawihub/src/modules/places/data/models/place_location.dart';
import 'package:hawihub/src/modules/main/view/screens/view_image_screen.dart';
import 'package:hawihub/src/modules/places/view/widgets/components.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/color_manager.dart';

class PlaceScreen extends StatelessWidget {
  final int placeId;

  const PlaceScreen({super.key, required this.placeId});

  @override
  Widget build(BuildContext context) {
    PlaceBloc bloc = PlaceBloc.get();
    late Place place;
    if (bloc.allPlaces.any((e) => e.id == placeId)) {
      place = bloc.allPlaces.firstWhere(
        (e) => e.id == placeId,
      );
      bloc.currentPlace = place;
    } else {
      bloc.add(GetPlaceEvent(placeId));
    }

    return Scaffold(
        body: BlocBuilder<PlaceBloc, PlaceState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          current is PlaceError ||
          current is GetPlaceSuccess ||
          previous is GetPlaceSuccess,
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: BlocListener<PlaceBloc, PlaceState>(
                  bloc: bloc,
                  listener: (context, state) {
                    if (state is PlaceError) {
                      errorToast(
                          msg: ExceptionManager(state.exception)
                              .translatedMessage());
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // app bar
                      ImageSliderWithIndicators(
                        imageUrls: place.images
                            .map((e) => ApiManager.handleImageUrl(e))
                            .toList(),
                        placeId: place.id,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleText(place.name),
                            SizedBox(
                              height: 3.h,
                            ),
                            _buildCaptionWidget(
                                place.description ?? "", context),
                            SizedBox(
                              height: 2.h,
                            ),
                            SubTitle(S.of(context).location),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              place.address,
                              style: TextStyleManager.getCaptionStyle(),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            if (place.location != null)
                              _buildShowMapWidget(context),
                            ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              title: SubTitle(S.of(context).workingHours),
                              childrenPadding: EdgeInsets.zero,
                              children: [
                                _buildWorkingHours(context),
                              ],
                            ),
                            Divider(
                              height: 5.h,
                            ),
                            SizedBox(
                              height: 4.h,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: (place.rating != null)
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  place.rating.toString(),
                                                  style: TextStyleManager
                                                      .getBlackCaptionTextStyle(),
                                                ),
                                                Expanded(
                                                  child: place.rating != null
                                                      ? Center(
                                                          child: SizedBox(
                                                            height: 20.sp,
                                                            child: RatingBar
                                                                .builder(
                                                              glow: true,
                                                              itemSize: 20.sp,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              wrapAlignment:
                                                                  WrapAlignment
                                                                      .center,
                                                              initialRating: place
                                                                  .rating!
                                                                  .toDouble(),
                                                              itemCount: 5,
                                                              glowColor:
                                                                  ColorManager
                                                                      .golden,
                                                              ignoreGestures:
                                                                  true,
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      const Icon(
                                                                Icons.star,
                                                                color:
                                                                    ColorManager
                                                                        .golden,
                                                              ),
                                                              onRatingUpdate:
                                                                  (r) {},
                                                            ),
                                                          ),
                                                        )
                                                      : Text(S
                                                          .of(context)
                                                          .noRatings),
                                                ),
                                              ],
                                            )
                                          : Center(
                                              child:
                                                  Text(S.of(context).noRatings),
                                            )),
                                  const VerticalDivider(),
                                  Expanded(
                                      child: Row(
                                    children: [
                                      Text(place.totalGames.toString()),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(S.of(context).totalGames,
                                          style: TextStyleManager
                                              .getBlackCaptionTextStyle()),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Center(
                                child: TextButton(
                                    onPressed: () {
                                      context.push(Routes.placeFeedbacks,
                                          arguments: {"id": place.id});
                                    },
                                    child: Text(S.of(context).viewFeedbacks,
                                        style: TextStyleManager
                                            .getGoldenRegularStyle()))),
                            SubTitle(S.of(context).sport),
                            SizedBox(
                              height: 1.h,
                            ),
                            buildSportWidget(
                                sportId: place.sport,
                                MainCubit.get()
                                    .sportsList
                                    .firstWhere(
                                        (element) => place.sport == element.id,
                                        orElse: () => Sport.unKnown())
                                    .name,
                                context),
                            Divider(
                              height: 4.h,
                            ),
                            SubTitle(S.of(context).booking),
                            SizedBox(
                              height: 2.h,
                            ),
                            SizedBox(
                              height: 3.h,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          S.of(context).price,
                                        ),
                                      ),
                                    ),
                                    const VerticalDivider(),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          S.of(context).minimumBooking,
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            SizedBox(
                              height: 5.h,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: OutLineContainer(
                                        child: Text(
                                          "${place.price}  ${S.of(context).sar} ${S.of(context).perHour}",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Expanded(
                                      child: OutLineContainer(
                                        child: Text(
                                          "${place.minimumHours ?? S.of(context).noMinimumBooking}  ${S.of(context).hours}",
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            OutLineContainer(
                              color: ColorManager.grey1,
                              child: SubTitle(
                                S.of(context).createGame,
                                isBold: false,
                              ),
                              onPressed: () {
                                context.push(Routes.createGame,
                                    arguments: {"placeId": place.id});
                              },
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            InkWell(
                              onTap: () {
                                context.push(
                                  Routes.profile,
                                  arguments: {
                                    'id': place.ownerId,
                                    "userType": "Owner"
                                  },
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        ApiManager.handleImageUrl(
                                            place.ownerImage)),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Expanded(child: SubTitle(place.ownerName)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: DefaultButton(
                  text: S.of(context).bookNow,
                  onPressed: () {
                    if (ConstantsManager.appUser == null) {
                      errorToast(msg: S.of(context).loginFirst);
                    } else {
                      context.push(Routes.bookNow, arguments: {"id": place.id});
                      debugPrint("Book Now");
                    }
                  }),
            ),
            SizedBox(
              height: 2.h,
            ),
            if (ConstantsManager.appUser != null &&
                ConstantsManager.appUser!.stadiumReservation.contains(placeId))
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: BlocListener<PlaceBloc, PlaceState>(
                  bloc: PlaceBloc.get(),
                  listener: (context, state) {
                    if (state is AddPlaceFeedbackError) {
                      errorToast(
                          msg: ExceptionManager(state.exception)
                              .translatedMessage());
                    }
                    if (state is AddPlaceFeedbackSuccess) {
                      defaultToast(msg: S.of(context).saved);
                    }
                  },
                  child: DefaultButton(
                    isLoading: PlaceBloc.get().state is AddPlaceFeedbackLoading,
                    onPressed: () {
                      context.pushWithTransition(AddFeedbackForClub(
                        place: place,
                      ));
                    },
                    text: S.of(context).addFeedback,
                  ),
                ),
              ),
            SizedBox(
              height: 2.h,
            ),
          ],
        );
      },
    ));
  }

  Widget _buildShowMapWidget(BuildContext context) {
    print("location : ${PlaceBloc.get().currentPlace!.location}");
    return InkWell(
      onTap: () async {
        PlaceLocation location = PlaceBloc.get().currentPlace!.location!;
        MapsLauncher.launchCoordinates(location.latitude, location.longitude)
            .catchError((e) {
          debugPrint(e.toString());
        });
      },
      child: Container(
          height: 4.h,
          width: 35.w,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorManager.secondary,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Row(
            children: [
              Icon(
                color: ColorManager.error,
                Icons.location_on,
              ),
              Expanded(
                child: Text(
                  S.of(context).showInMap,
                  style: TextStyleManager.getSecondaryRegularStyle(),
                ),
              ),
            ],
          ))),
    );
  }

  Widget buildSportWidget(String sport, BuildContext context,
      {required int sportId}) {
    return Container(
      height: 5.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.grey1,
      ),
      child: InkWell(
          onTap: () {
            context
                .push(Routes.exploreBySport, arguments: {"sportId": sportId});
          },
          child: Center(
              child: Text(sport,
                  style: TextStyleManager.getBlackCaptionTextStyle()))),
    );
  }

  Widget _buildCaptionWidget(String caption, BuildContext context) {
    return ExpandableText(
      caption,
      expandText: S.of(context).showMore,
      animation: true,
      collapseOnTextTap: true,
    );
  }

  Widget _buildWorkingHours(BuildContext context) {
    Place place = PlaceBloc.get().allPlaces.firstWhere(
          (e) => e.id == placeId,
        );
    if (_placeIsAlwaysOpen()) {
      return OutLineContainer(child: Text(S.of(context).alwaysOpen));
    } else {
      return SizedBox(
        child: Column(children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            Expanded(
              child: _buildDay(
                place.workingHours![0],
                context,
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              child: _buildDay(
                place.workingHours![1],
                context,
              ),
            ),
          ]),
          SizedBox(
            height: 1.h,
          ),
          Row(children: [
            Expanded(
              child: _buildDay(
                place.workingHours![2],
                context,
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              child: _buildDay(
                place.workingHours![3],
                context,
              ),
            ),
          ]),
          SizedBox(
            height: 1.h,
          ),
          Row(children: [
            Expanded(
              child: _buildDay(
                place.workingHours![4],
                context,
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              child: _buildDay(
                place.workingHours![5],
                context,
              ),
            ),
          ]),
          SizedBox(
            height: 1.h,
          ),
          _buildDay(
            place.workingHours![6],
            context,
          ),
        ]),
      );
    }
  }

  bool _placeIsAlwaysOpen() {
    Place place = PlaceBloc.get().allPlaces.firstWhere(
          (e) => e.id == placeId,
        );
    // check if place working hours list is all open from 00:00 to 24:00
    return place.workingHours!.where((element) => element.isAllDay()).length ==
        place.workingHours!.length;
  }

  Widget _buildDay(
    Day day,
    BuildContext context,
  ) {
    return OutLineContainer(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Text(
            maxLines: 2,
            softWrap: true,
            day.isAllDay()
                ? S.of(context).alwaysOpen
                : day.isWeekend()
                    ? "${LocalizationManager.getDays()[day.dayOfWeek]}: ${S.of(context).weekend}"
                    : "${LocalizationManager.getDays()[day.dayOfWeek]}: ${day.startTime.format(context)} - ${day.endTime.format(context)}",
            style: TextStyle(
              fontWeight: FontWeightManager.bold,
              fontSize: FontSizeManager.s10,
            )),
      ),
    );
  }
}

class ImageSliderWithIndicators extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final int placeId;

  ImageSliderWithIndicators({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
    required this.placeId,
  });

  @override
  _ImageSliderWithIndicatorsState createState() =>
      _ImageSliderWithIndicatorsState();
}

class _ImageSliderWithIndicatorsState extends State<ImageSliderWithIndicators> {
  int _currentIndex = 0;
  CarouselSliderController _carouselController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _startAutoPlayTimer();
  }

  void _startAutoPlayTimer() {
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        _carouselController.nextPage();
        _startAutoPlayTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;
    if (ConstantsManager.appUser != null) {
      if (ConstantsManager.appUser!.favoritePlaces.contains(widget.placeId)) {
        isFavorite = true;
      }
    }
    return SizedBox(
      width: 100.w,
      height: 50.h,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Hero(
                  tag: widget.placeId,
                  child: CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: false,
                      viewportFraction: 1.0,
                      aspectRatio: 1 / 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: widget.imageUrls.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              context.push(Routes.viewImages, arguments: {
                                "imageUrls": widget.imageUrls,
                                "index": _currentIndex,
                              });
                            },
                            child: Container(
                              width: 100.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
              // LinearProgressIndicator(
              //   value: _progress,
              //   backgroundColor: Colors.black26,
              //   color: Colors.white,
              // )
            ],
          ),
          // Indicator for current image number
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  '  ${_currentIndex + 1} / ${widget.imageUrls.length}  ',
                  style: const TextStyle(color: ColorManager.white),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: ColorManager.black.withOpacity(0.5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SafeArea(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: ColorManager.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        // focusColor: Colors.white,

                        onPressed: () {
                          Share.shareUri(Uri.parse(
                              "${ApiManager.domain}/place/?id=${widget.placeId}"));
                        },
                        icon: Icon(Icons.share, color: ColorManager.white),
                      ),
                      const Spacer(),
                      if (ConstantsManager.appUser != null)
                        FavoriteIconButton(
                          color: ColorManager.white,
                          placeId: widget.placeId,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
