import 'package:flutter/material.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/routing/routes.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/places/data/models/place.dart';
import 'package:sizer/sizer.dart';

class PlaceItem extends StatelessWidget {
  final Place place;
  const PlaceItem({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(Routes.place, arguments: {"id": place.id});
      },
      child: Container(
        padding: EdgeInsets.all(10.sp),
        width: 90.w,
        height: 27.h,
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
                Expanded(
                    child: Row(children: [
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              place.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleManager.getSubTitleBoldStyle(),
                            ),
                          ),
                          Text(S.of(context).viewDetails,
                              style: TextStyleManager.getGoldenRegularStyle()),
                          const Icon(
                            Icons.arrow_forward,
                            color: ColorManager.golden,
                          )
                        ],
                      ),
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          place.address,
                          style: TextStyleManager.getCaptionStyle(),
                        ),
                      ),
                    ]),
                  ),
                ]))
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
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    color: Colors.black.withOpacity(0.4),
                  ),
                  height: 3.h,
                  constraints: BoxConstraints(minWidth: 20.w, maxWidth: 50.w),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(place.ownerName,
                        textAlign: TextAlign.center,
                        style: TextStyleManager.getBlackContainerTextStyle()),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SportItem extends StatelessWidget {
  final String sportName;
  final IconData sportIcon;
  const SportItem({super.key, required this.sportName, required this.sportIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      height: 10.h,
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(5.sp),
      ),
      child: Column(children: [
        Icon(
          sportIcon,
        ),
        Text(sportName)
      ]),
    );
  }
}
