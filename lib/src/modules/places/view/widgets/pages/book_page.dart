import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/main.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/modules/main/view/widgets/main_app_bar.dart';
import 'package:hawihub/src/modules/places/view/widgets/components.dart';
import 'package:hawihub/src/modules/places/view/widgets/shimmers/place_shimmers.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../bloc/place_bloc.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    PlaceBloc placeBloc = PlaceBloc.get();
    return Column(
      children: [
        const MainAppBar(),
        BlocListener<PlaceBloc, PlaceState>(
          bloc: placeBloc,
          listener: (context, state) {
            if (state is PlaceError) {
              errorToast(
                  msg: ExceptionManager(state.exception).translatedMessage());
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
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 2.h,
                    ),
                    itemBuilder: (context, index) => state
                            is GetAllPlacesLoading
                        ? PlaceItem(place: dummyPlaces[index])
                        : PlaceItem(place: PlaceBloc.get().viewedPlaces[index]),
                    itemCount: state is GetAllPlacesLoading
                        ? dummyPlaces.length
                        : placeBloc.viewedPlaces.length,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
