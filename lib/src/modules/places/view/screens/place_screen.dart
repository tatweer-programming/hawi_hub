import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawihub/src/modules/places/data/models/place.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/utils/color_manager.dart';

class PlaceScreen extends StatelessWidget {
  final int placeId;
  const PlaceScreen({super.key, required this.placeId});

  @override
  Widget build(BuildContext context) {
    Place place = Place(
        latitudes: "",
        longitudes: "",
        totalGames: 122,
        totalRatings: 90,
        rating: 3.5,
        address:
            "place address place address place address place address place address place address place address place address",
        ownerId: 1,
        name: "Place name",
        description:
            "place place place place place place place place place place place place place place place place place place place place place place place place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description ",
        images: const [
          "https://www.sofistadium.com/assets/img/SoFiStadium_bowl-9f3e09bf67.jpg",
          "https://www.accoes.com/wp-content/uploads/2022/08/IMG_5382-scaled.jpg",
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9E2ITnbivkVxMi2refJT2OUZb4SaCOZJJeIvMjUwgWCiHoFLnKUOU7m1a4wz1Lp9_Hzo&usqp=CAU",
        ],
        id: 1,
        ownerImageUrl: '',
        ownerName: 'owner name',
        sport: '',
        price: 0,
        minimumHours: 0,
        reservations: [],
        feedbacks: []);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.h,
            width: double.infinity,
            child: Stack(
              children: [
                CustomAppBar(height: 35.h, child: const SizedBox()),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                      width: 95.w,
                      height: 30.h,
                      child: Stack(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              reverse: false,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              autoPlay: true,
                              pauseAutoPlayInFiniteScroll: true,
                              pauseAutoPlayOnTouch: true,
                              // aspectRatio: 90.w / 30.h,
                              viewportFraction: 0.99,
                              padEnds: false,
                              pauseAutoPlayOnManualNavigate: true,
                              height: 30.h,
                            ),
                            items: place.images.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: 88.w,
                                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.grey,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(i),
                                        )),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              // focusColor: Colors.white,
                              color: ColorManager.primary,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.arrow_back_ios_new)),
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.all(5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  style: TextStyleManager.getTitleBoldStyle(),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  place.address,
                  style: TextStyleManager.getRegularStyle(),
                ),
                SizedBox(
                  width: 45.w,
                  child: Divider(
                    height: 5.h,
                  ),
                ),
                Text(
                  S.of(context).availableTimes,
                  style: TextStyleManager.getSubTitleBoldStyle(),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
