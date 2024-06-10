import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/routing/routes.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/localization_manager.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get();
    return Align(
      alignment: AlignmentDirectional.topCenter,
      heightFactor: 0.85,
      child: CustomAppBar(
        height: 33.h,
        opacity: .15,
        backgroundImage: "assets/images/app_bar_backgrounds/1.webp",
        actions: [
          IconButton(
              onPressed: () {
                context.push(Routes.notifications);
              },
              icon: const ImageIcon(
                AssetImage("assets/images/icons/notification.webp"),
                color: ColorManager.golden,
              )),
          InkWell(
            radius: 360,
            onTap: () {
              context.push(Routes.profile);
            },
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://img.freepik.com/free-vector/isolated-young-handsome-man-set-different-poses-white-background-illustration_632498-649.jpg?t=st=1711503056~exp=1711506656~hmac=9aea7449b3ae3f763053d68d15a49e3c70fa1e73e98311d518de5f01c2c3d41c&w=740"),
              backgroundColor: ColorManager.golden,
            ),
          ),
        ],
        leading: BlocBuilder<MainCubit, MainState>(
          bloc: mainCubit,
          builder: (context, state) {
            return CityDropdown(
                selectedCity: mainCubit.currentCityId == null
                    ? S.of(context).chooseSport
                    : LocalizationManager
                        .getSaudiCities[mainCubit.currentCityId! - 1],
                onCitySelected: (c) async {
                  await mainCubit.selectCity(c);
                },
                cities: LocalizationManager.getSaudiCities);
          },
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 7.h,
            child: dropdownBuilder(
                text: S.of(context).chooseSport,
                onChanged: (val) {
                  //  placeBloc.add(ChooseSportEvent(val!));
                },
                items: MainCubit.get().sportsList.map((e) => e.name).toList()),
          ),
        ),
      ),
    );
  }
}
