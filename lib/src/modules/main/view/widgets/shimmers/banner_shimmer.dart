import 'package:flutter/material.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class BannersShimmer extends StatelessWidget {
  const BannersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: ColorManager.grey2,
        highlightColor: ColorManager.grey1,
        enabled: true,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 88.w,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey,
                ),
              );
            }));
  }
}
