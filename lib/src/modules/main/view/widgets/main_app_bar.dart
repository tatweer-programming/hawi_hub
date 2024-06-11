import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/routing/routes.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
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
              context.push(
                Routes.profile,
                arguments: ConstantsManager.appUser,
              );
            },
            child: CircleAvatar(
              backgroundColor: ColorManager.grey3,
              backgroundImage: ConstantsManager.appUser != null && ConstantsManager.appUser!.profilePictureUrl != null
                  ? NetworkImage(ConstantsManager.appUser!.profilePictureUrl!)
                  : const AssetImage("assets/images/icons/user.png")
              as ImageProvider<Object>,
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
