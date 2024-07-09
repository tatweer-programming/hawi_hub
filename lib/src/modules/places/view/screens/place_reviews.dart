import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawihub/src/modules/places/bloc/place_bloc.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';
import 'package:hawihub/src/modules/places/view/widgets/components.dart';
import 'package:sizer/sizer.dart';

import '../../data/models/place.dart';

class PlaceFeedbacksScreen extends StatelessWidget {
  final int id;

  const PlaceFeedbacksScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    PlaceBloc placeCubit = PlaceBloc.get();

    Place currentPlace =
        placeCubit.allPlaces.firstWhere((element) => element.id == id);
    List<AppFeedBack> feedbacks = currentPlace.feedbacks ?? [];
    if (currentPlace.feedbacks == null || currentPlace.feedbacks!.isEmpty) {
      placeCubit.add(GetPlaceReviewsEvent(id));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              actions: [
                SizedBox(
                  height: 5.h,
                )
              ],
              height: 33.h,
              opacity: .15,
              backgroundImage: "assets/images/app_bar_backgrounds/5.webp",
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: SizedBox(
                  height: 7.h,
                  child: Text(
                    S.of(context).feedbacks,
                    style: TextStyleManager.getAppBarTextStyle(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: BlocListener<PlaceBloc, PlaceState>(
                listener: (context, state) {
                  if (state is PlaceError) {
                    errorToast(
                        msg: ExceptionManager(state.exception)
                            .translatedMessage());
                  }
                  if (state is GetPlaceReviewsSuccess) {
                    feedbacks = state.feedBacks;
                  }
                },
                child: BlocBuilder<PlaceBloc, PlaceState>(
                    bloc: placeCubit,
                    builder: (context, state) {
                      return state is GetPlaceReviewsLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : feedbacks.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: Center(
                                      child:
                                          SubTitle(S.of(context).noFeedbacks)),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: feedbacks.length,
                                  itemBuilder: (context, index) {
                                    return FeedBackWidget(
                                        feedBack: feedbacks[index]);
                                  });
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
