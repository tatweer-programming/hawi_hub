import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../main/view/widgets/custom_app_bar.dart';
import '../../../data/models/place.dart';
import '../components.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

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
        ],
        id: 1,
        ownerImageUrl: '',
        ownerName: 'owner name',
        sport: '',
        price: 0,
        minimumHours: 0,
        reservations: [],
        feedbacks: []);
    return Column(
      children: [
        CustomAppBar(
          color: ColorManager.transparent,
          opacity: .1,
          blendMode: BlendMode.difference,
          backgroundImage: "assets/images/app_bar_backgrounds/7.webp",
          height: 35.h,
          actions: const [
            //   Icon(Icons.notifications),
          ],
          child: const Text(
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            "",
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.w),
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (itemContext, index) {
                return PlaceItem(place: place);
              },
              separatorBuilder: (itemContext, index) {
                return SizedBox(
                  height: 10.sp,
                );
              },
              itemCount: 10),
        ),
      ],
    );
  }
}
