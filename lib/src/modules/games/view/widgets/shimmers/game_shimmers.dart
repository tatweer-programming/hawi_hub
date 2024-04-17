import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hawihub/src/modules/games/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/shimmers/shimmer_widget.dart';
import 'package:hawihub/src/modules/main/view/widgets/shimmers/place_holder.dart';
import 'package:sizer/sizer.dart';

class VerticalGamesShimmer extends StatelessWidget {
  const VerticalGamesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
              height: 2.h,
            ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return const GameItemShimmer();
        });
  }
}

class HorizontalGamesShimmer extends StatelessWidget {
  const HorizontalGamesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15.h,
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
                width: 4.w,
              ),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return const GameItemShimmer(); //  const GameItemShimmer();
          }),
    );
  }
}

class GameItemShimmer extends StatelessWidget {
  const GameItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
        height: 15.h,
        width: 85.w,
        placeholder: Container(
          //  padding: EdgeInsets.all(10.sp),
          clipBehavior: Clip.hardEdge,
          width: 90.w,
          height: 27.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all()),
          child: Row(
            children: [
              ShimmerPlaceHolder(
                height: double.infinity,
                width: 25.w,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerPlaceHolder(
                        height: 3.h,
                      ),
                      SizedBox(height: 1.h),
                      ShimmerPlaceHolder(
                        width: 30.w,
                        height: 2.5.h,
                      ),
                      SizedBox(height: 1.h),
                      ShimmerPlaceHolder(
                        width: 25.w,
                        height: 2.h,
                      ),
                      SizedBox(height: 1.h),
                      const ShimmerPlaceHolder(),
                      SizedBox(height: 1.h),
                      const ShimmerPlaceHolder(),
                    ],
                  ),
                ),
              ),
              ShimmerPlaceHolder(
                height: double.infinity,
                width: 11.w,
              )
            ],
          ),
        ));
  }
}
