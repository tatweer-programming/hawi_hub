import 'package:flutter/material.dart';
import 'package:hawihub/src/modules/places/data/models/place.dart';
import 'package:hawihub/src/modules/places/view/widgets/components.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      feedbacks: [],
      reservations: [],
    );
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlaceItem(
              place: place,
            )),
      ),
    );
  }
}
