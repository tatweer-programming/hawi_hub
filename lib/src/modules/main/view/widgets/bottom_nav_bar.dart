import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/core/utils/font_manager.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/color_manager.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get();
    return BlocBuilder<MainCubit, MainState>(
      bloc: mainCubit,
      builder: (context, state) {
        return SizedBox(
          height: 7.5.h,
          width: double.infinity,
          child: Stack(children: [
            Center(
              child: Container(
                color: ColorManager.primary,
                height: 2.5.h,
                width: double.infinity,
              ),
            ),
            const Positioned.fill(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NavBarItem(
                    index: 0,
                    icon: "assets/images/icons/home.webp",
                    label: "Home",
                  ),
                  NavBarItem(
                    icon: "assets/images/icons/play.webp",
                    label: "Play",
                    index: 1,
                  ),
                  NavBarItem(
                    icon: "assets/images/icons/book.webp",
                    label: "Book",
                    index: 2,
                  ),
                  NavBarItem(
                    icon: "assets/images/icons/more.webp",
                    label: "More",
                    index: 3,
                  )
                ],
              ),
            )
          ]),
        );
      },
    );
  }
}

class NavBarItem extends StatefulWidget {
  final String icon;
  final String label;

  final int index;

  const NavBarItem({super.key, required this.icon, required this.label, required this.index});

  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  MainCubit cubit = MainCubit.get();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      bloc: cubit,
      builder: (context, state) {
        return Expanded(
          child: CircleAvatar(
            radius: double.maxFinite,
            backgroundColor:
                cubit.currentIndex == widget.index ? ColorManager.primary : Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(360),
                radius: 360,
                onTap: () {
                  cubit.changePage(widget.index);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 1.h),
                    Expanded(
                        child: FittedBox(
                      fit: BoxFit.fill,
                      child: ImageIcon(
                          size: 35.sp,
                          AssetImage(
                            widget.icon,
                          ),
                          color:
                              cubit.currentIndex == widget.index ? Colors.white : Colors.grey[600]),
                    )),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(widget.label,
                          style: TextStyle(
                              fontSize: FontSizeManager.s11,
                              color: cubit.currentIndex == widget.index
                                  ? Colors.white
                                  : Colors.grey[600])),
                    ),
                    SizedBox(height: 1.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
