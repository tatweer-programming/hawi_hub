import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/connectivity.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawihub/src/modules/main/view/widgets/shimmers/banner_shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../places/data/models/place.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get()..getBanner();
    return Column(
      children: [
        CustomAppBar(
          height: 33.h,
          opacity: .15,
          backgroundImage: "assets/images/app_bar_backgrounds/1.webp",
          actions: [
            IconButton(
                onPressed: () {},
                icon: const ImageIcon(
                  AssetImage("assets/images/icons/notification.webp"),
                  color: ColorManager.golden,
                )),
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://img.freepik.com/free-vector/isolated-young-handsome-man-set-different-poses-white-background-illustration_632498-649.jpg?t=st=1711503056~exp=1711506656~hmac=9aea7449b3ae3f763053d68d15a49e3c70fa1e73e98311d518de5f01c2c3d41c&w=740"),
              backgroundColor: ColorManager.golden,
            ),
          ],
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 7.h,
              child: const TextField(
                  decoration: InputDecoration(
                hintText: "choose sport",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.expand_circle_down),
              )),
            ),
          ),
        ),
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
                    text: "create game",
                    onPressed: () {},
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
                                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.grey,
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
              ])),
        ),
      ],
    );
  }

  void retryConnecting() async {
    MainCubit.get().getBanner();
  }
}

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
  sport: 'Football',
  price: 0,
  minimumHours: 0,
  reservations: [],
  feedbacks: [],
);
