import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawihub/src/modules/auth/data/models/user.dart';
import 'package:hawihub/src/modules/auth/view/widgets/auth_app_bar.dart';
import 'package:hawihub/src/modules/places/bloc/place__bloc.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/styles_manager.dart';
import '../../../auth/view/widgets/widgets.dart';

class AddFeedbackForUser extends StatelessWidget {
  final User user;
  final AuthBloc authBloc;

  const AddFeedbackForUser({super.key, required this.user, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    TextEditingController addCommentController = TextEditingController();
    PlaceBloc bloc = PlaceBloc.get();
    double rating = 5;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AuthAppBar(
              context: context,
              user: user,
              title: S.of(context).feedbacks,
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              user.userName,
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
                    },
                    builder: (context, state) {
                     return _rateBuilder(
                       rate: S.of(context).ownerRate,
                       onRatingUpdate: (rating) {
                         bloc.add(AddRatingEvent(rating));
                       },
                     );
                    }
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
                  BlocConsumer<PlaceBloc, PlaceState>(
                    listener: (context, state) {
                       if(state is AddOwnerFeedbackSuccess){
                         context.pop();
                         context.pop();
                       }
                    },
                    builder: (context, state) {
                      return defaultButton(
                        onPressed: () {
                          bloc.add(AddOwnerFeedbackEvent(
                              ConstantsManager.userId!,
                              review: AppFeedBack(
                                  userId: user.id,
                                  comment: addCommentController.text,
                                  rating: rating)));
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
