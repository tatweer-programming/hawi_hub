import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawihub/src/modules/places/data/models/place.dart';
import 'package:sizer/sizer.dart';

class PlaceItem extends StatelessWidget {
  final Place place;
  const PlaceItem({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      width: 90.w,
      height: 35.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp), border: Border.all()),
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: double.infinity,
                height: 15.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(place.images.first),
                    )),
              ),
              Text(
                place.name,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  place.description,
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                ),
              ),
              RatingBar.builder(
                itemSize: 20.sp,
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
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
              )
            ]),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_outlined,
                  color: Colors.red,
                )),
          )
        ],
      ),
    );
  }
}
