import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/pages/home_page.dart';
import 'package:hawihub/src/modules/places/view/widgets/components.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExploreSportsList extends StatelessWidget {
  const ExploreSportsList({super.key});

  @override
  Widget build(BuildContext context) {
    final mainCubit = MainCubit.get();
    final SizedBox heightSpacer = SizedBox(height: 2.h);
    return Column(
      children: [
        heightSpacer,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: TitleText(S.of(context).exploreBySports, isBold: true)),
            const SizedBox(),
          ],
        ),
        heightSpacer,
        SizedBox(
          height: 15.h,
          child: BlocBuilder<MainCubit, MainState>(
            bloc: mainCubit,
            builder: (context, state) {
              return Skeletonizer(
                justifyMultiLineText: false,
                ignorePointers: false,
                ignoreContainers: false,
                effect: const PulseEffect(),
                enabled: state is GetSportsLoading,
                child:
                    mainCubit.sportsList.isEmpty && state is! GetSportsLoading
                        ? const EmptyView()
                        : ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              width: 3.w,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: state is GetSportsLoading
                                ? dummySports.length
                                : mainCubit.sportsList.length,
                            itemBuilder: (context, index) {
                              return SportItemWidget(
                                sport: state is GetSportsLoading
                                    ? dummySports[index]
                                    : mainCubit.sportsList[index],
                              );
                            },
                          ),
              );
            },
          ),
        ),
      ],
    );
  }
}
