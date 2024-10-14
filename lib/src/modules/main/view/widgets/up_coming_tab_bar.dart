import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:sizer/sizer.dart';

class UpComingTabBar extends StatelessWidget {
  const UpComingTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get();
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
        color: ColorManager.grey2,
        borderRadius: BorderRadius.circular(20),
      ),
      child: BlocBuilder<MainCubit, MainState>(
        bloc: mainCubit,
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: mainCubit.currentTab == 0
                        ? ColorManager.primary
                        : ColorManager.grey2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      mainCubit.changeUpcomingTab(0);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          S.of(context).upcomingGames,
                          style: const TextStyle(
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: mainCubit.currentTab == 1
                        ? ColorManager.primary
                        : ColorManager.grey2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      mainCubit.changeUpcomingTab(1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          S.of(context).upcomingReservations,
                          style: const TextStyle(
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
