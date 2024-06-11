import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/auth/view/widgets/widgets.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

class AddFeedback extends StatelessWidget {
  const AddFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController addCommentController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Column(
                  children: [
                    CustomAppBar(
                      backgroundImage:
                          "assets/images/app_bar_backgrounds/6.webp",
                      height: 32.h,
                      child: Container(),
                    ),
                    SizedBox(
                      height: 5.h,
                    )
                  ],
                ),
                Container(
                  height: 25.h,
                  width: 86.w,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                    color: ColorManager.grey1,
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              "Cairo Stadium",
              style: TextStyleManager.getTitleBoldStyle()
                  .copyWith(fontSize: 21.sp),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 6.w,
              ),
              child: Column(
                children: [
                  _rateBuilder(
                    rate: S.of(context).clubRate,
                    initialRating: 5,
                    onRatingUpdate: (rating) {},
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  _rateBuilder(
                    rate: S.of(context).ownerRate,
                    initialRating: 2,
                    onRatingUpdate: (rating) {},
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  mainFormField(
                    controller: addCommentController,
                    hint: S.of(context).addComment,
                    borderColor: ColorManager.black,
                    hintStyle: const TextStyle(
                      color: ColorManager.secondary,
                    ),
                    maxLines: 6,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  defaultButton(
                    onPressed: () {},
                    text: S.of(context).send,
                    fontSize: 18.sp,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _rateBuilder({
  required String rate,
  required double initialRating,
  required Function(double) onRatingUpdate,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        rate,
        style: TextStyleManager.getTitleBoldStyle()
            .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 1.h,
      ),
      RatingBar.builder(
        initialRating: initialRating,
        minRating: 1,
        itemSize: 25.sp,
        direction: Axis.horizontal,
        ignoreGestures: false,
        allowHalfRating: true,
        itemPadding: EdgeInsets.zero,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: ColorManager.golden,
        ),
        onRatingUpdate: onRatingUpdate,
      ),
      SizedBox(
        height: 3.h,
      ),
      Container(
        height: 0.2.h,
        width: 88.w,
        color: ColorManager.grey2,
      )
    ],
  );
}
