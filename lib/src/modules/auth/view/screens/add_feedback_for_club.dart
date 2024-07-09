import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/modules/places/bloc/place_bloc.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';
import 'package:hawihub/src/modules/places/data/proxy/data_source_proxy.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/styles_manager.dart';
import '../../../auth/view/widgets/widgets.dart';
import '../../../main/view/widgets/custom_app_bar.dart';
import '../../../places/data/models/place.dart';

class AddFeedbackForClub extends StatelessWidget {
  final Place place;

  const AddFeedbackForClub({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    TextEditingController addCommentController = TextEditingController();
    PlaceBloc bloc = PlaceBloc.get();
    double rating = 5;
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
                    ),
                  ],
                ),
                Container(
                  height: 25.h,
                  width: 86.w,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                    color: ColorManager.grey1,
                    image: place.images.isEmpty
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(place.images[0]),
                          ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              place.name,
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
                  BlocConsumer<PlaceBloc, PlaceState>(
                      listener: (context, state) {
                    if (state is AddRatingState) {
                      rating = state.rating;
                    }
                  }, builder: (context, state) {
                    return _rateBuilder(
                      rate: S.of(context).ownerRate,
                      onRatingUpdate: (rating) {
                        UserAccessProxy(bloc, AddRatingEvent(rating))
                            .execute([AccessCheckType.login]);
                      },
                    );
                  }),
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
                  BlocConsumer<PlaceBloc, PlaceState>(
                    listener: (context, state) {
                      if (state is AddOwnerFeedbackSuccess) {
                        context.pop();
                      }
                    },
                    builder: (context, state) {
                      return defaultButton(
                        onPressed: () {
                          UserAccessProxy(
                            bloc,
                            AddPlaceFeedbackEvent(place.id,
                                review: AppFeedBack(
                                    userId: ConstantsManager.userId!,
                                    comment: addCommentController.text,
                                    rating: rating)),
                          ).execute([AccessCheckType.login]);
                        },
                        text: S.of(context).send,
                        fontSize: 18.sp,
                      );
                    },
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
        initialRating: 5,
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
