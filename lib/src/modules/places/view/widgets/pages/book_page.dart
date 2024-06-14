import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/routing/routes.dart';
import 'package:hawihub/src/core/utils/localization_manager.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/main_app_bar.dart';
import 'package:hawihub/src/modules/places/view/widgets/components.dart';
import 'package:hawihub/src/modules/places/view/widgets/shimmers/place_shimmers.dart';
import 'package:sizer/sizer.dart';
import '../../../bloc/place__bloc.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    PlaceBloc placeBloc = PlaceBloc.get();
    return Column(
      children: [
        const MainAppBar(),
        BlocBuilder<PlaceBloc, PlaceState>(
          bloc: placeBloc,
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(5.w),
              child: state is GetPlaceLoading
                  ? const VerticalPlacesShimmer()
                  :  placeBloc.viewedPlaces.isEmpty ? const EmptyView() : ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 2.h,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: placeBloc.viewedPlaces.length,
                      itemBuilder: (context, index) => PlaceItem(
                        place: placeBloc.viewedPlaces[index],
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }
}
