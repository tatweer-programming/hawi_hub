import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/view/widgets/bottom_nav_bar.dart';
import 'package:hawihub/src/modules/places/data/models/place.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get();
    Place place = Place(
      latitudes: "",
      longitudes: "",
      address:
          "place address place address place address place address place address place address place address place address",
      ownerId: 1,
      name: "owner name",
      description:
          "place place place place place place place place place place place place place place place place place place place place place place place place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description ",
      images: const [
        "https://upload.wikimedia.org/wikipedia/commons/1/18/Manchester_city_etihad_stadium_%28cropped%29.jpg",
      ],
      sport: "",
      id: 1,
      minimumHours: 0,
      price: 0,
      totalGames: 0,
      totalRatings: 0,
      rating: 0,
      ownerImageUrl: '',
      ownerName: '',
      feedbacks: const [],
      completedDays: const [],
    );
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: BlocBuilder<MainCubit, MainState>(
        bloc: mainCubit,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                mainCubit.pages[mainCubit.currentIndex],
                // Center(
                //   child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: PlaceItem(
                //         place: place,
                //       )),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
