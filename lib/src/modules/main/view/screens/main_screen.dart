import 'package:flutter/material.dart';
import 'package:hawihub/src/modules/places/data/models/place.dart';
import 'package:hawihub/src/modules/places/view/widgets/components.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Place place = Place(
        ownerId: 1,
        name: "owner name",
        description:
            "place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description ",
        images: [
          "https://upload.wikimedia.org/wikipedia/commons/1/18/Manchester_city_etihad_stadium_%28cropped%29.jpg",
        ],
        id: 1);
    return Scaffold(
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: PlaceItem(
              place: place,
            )),
      ),
    );
  }
}
