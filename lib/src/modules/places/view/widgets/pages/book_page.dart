import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/main.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/dummy/dummy_data.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawihub/src/modules/main/view/widgets/explore_sports_list.dart';
import 'package:hawihub/src/modules/main/view/widgets/main_app_bar.dart';
import 'package:hawihub/src/modules/places/view/widgets/components.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../bloc/place_bloc.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    PlaceBloc placeBloc = PlaceBloc.get();
    return SingleChildScrollView(
      child: Stack(
        children: [
          ImageAppBar(
            title: S.of(context).bookNow,
            imagePath: "assets/images/app_bar_backgrounds/football_player.jpg",
          ),
          Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: const ExploreSportsList(),
                    ),
                    BlocListener<PlaceBloc, PlaceState>(
                      bloc: placeBloc,
                      listener: (context, state) {
                        if (state is PlaceError) {
                          errorToast(
                              msg: ExceptionManager(state.exception)
                                  .translatedMessage());
                        }
                      },
                      child: BlocBuilder<PlaceBloc, PlaceState>(
                        bloc: placeBloc,
                        builder: (context, state) {
                          return Padding(
                            padding: EdgeInsets.all(5.w),
                            child: Skeletonizer(
                              justifyMultiLineText: true,
                              ignorePointers: false,
                              ignoreContainers: false,
                              effect: const PulseEffect(),
                              enabled: state is GetAllPlacesLoading,
                              child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 2.h,
                                ),
                                itemBuilder: (context, index) => state
                                        is GetAllPlacesLoading
                                    ? PlaceItem(place: dummyPlaces[index])
                                    : PlaceItem(
                                        place:
                                            PlaceBloc.get().allPlaces[index]),
                                itemCount: state is GetAllPlacesLoading
                                    ? dummyPlaces.length
                                    : placeBloc.allPlaces.length,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
