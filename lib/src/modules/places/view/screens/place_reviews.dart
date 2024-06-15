import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawihub/src/modules/places/bloc/place__bloc.dart';
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
              child: BlocBuilder<PlaceBloc, PlaceState>(
                  bloc: placeCubit,
                  builder: (context, state) {
                    return state is GetPlaceReviewsLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : currentPlace.feedbacks!.isEmpty
                            ? Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: Center(
                                    child: SubTitle(S.of(context).noFeedbacks)),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: currentPlace.feedbacks!.length,
                                itemBuilder: (context, index) {
                                  return FeedBackWidget(
                                      feedBack: currentPlace.feedbacks![index]);
                                });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
