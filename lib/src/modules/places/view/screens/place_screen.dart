import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/modules/places/data/models/place.dart';
import 'package:sizer/sizer.dart';

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
        name: "owner name",
        description:
            "place place place place place place place place place place place place place place place place place place place place place place place place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description place description ",
        images: const [
          "https://upload.wikimedia.org/wikipedia/commons/1/18/Manchester_city_etihad_stadium_%28cropped%29.jpg",
        ],
        id: 1,
        ownerImageUrl: '',
        ownerName: '',
        sport: '',
        price: 0,
        minimumHours: 0,
        reservations: [],
        feedbacks: []);
    return Scaffold(
        body: Stack(children: [
      Container(
        height: 35.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(place.images.first),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: 70.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.sp), topRight: Radius.circular(20.sp)),
              color: Colors.white,
            ),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    softWrap: false,
                    place.name,
                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on_outlined),
                      SizedBox(
                        width: 2.w,
                      ),
                      Expanded(
                          child: Text(place.address,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w300,
                              ))),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Container(
                          width: 45.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5.sp),
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(S.of(context).showInMap,
                                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold)),
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.green,
                            )
                          ]))),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.center,
                          "${place.totalGames} ${S.of(context).totalGames}",
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Container(
                            height: 2.h,
                            width: 1,
                            color: Colors.grey.shade800,
                          )),
                      Expanded(
                          child: Column(children: [
                        RatingBar.builder(
                          wrapAlignment: WrapAlignment.start,
                          itemSize: 18.sp,
                          initialRating: place.rating ?? 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ignoreGestures: true,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            if (kDebugMode) {
                              print(rating);
                            }
                          },
                        ),
                        Text(
                          "${place.totalRatings} ${S.of(context).ratingsCount}",
                        ),
                      ]))
                    ],
                  )
                ]),
              ),
            )),
      )
    ]));
  }
}
