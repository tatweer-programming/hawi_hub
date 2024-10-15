import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/modules/games/view/widgets/upcomming_games.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/main_app_bar.dart';
import 'package:hawihub/src/modules/main/view/widgets/up_coming_tab_bar.dart';
import 'package:hawihub/src/modules/places/view/widgets/upcomming_reservations.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../generated/l10n.dart';

class UpcomingReservationsPage extends StatelessWidget {
  const UpcomingReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get()..initializeUpcomingReservations();
    return RefreshIndicator(
      onRefresh: () async {
        mainCubit.initializeUpcomingReservations(refresh: true);
      },
      child: SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              verticalDirection: VerticalDirection.down,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DefaultAppBar(),
                SizedBox(height: 3.h),
                const UpComingTabBar(),
                SizedBox(height: 3.h),
                BlocBuilder<MainCubit, MainState>(
                    bloc: mainCubit,
                    builder: (context, state) {
                      return _pages[mainCubit.currentUpcomingTab];
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final List<Widget> _pages = const [
    UpComingGamesList(),
    UpComingReservationsList(),
  ];
}
