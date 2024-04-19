import 'package:flutter/material.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:sizer/sizer.dart';

import '../custom_app_bar.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            _appBar(context,
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyXXkiqJLhMZE69a4dTnH4Qd6GyzyFmqcmHu8EAhx8DQ&s"),
          ],
        ),
      ),
      SizedBox(
        height: 2.h,
      ),
      _settingWidget(
        onTap: () {},
        icon: "assets/images/icons/money.webp",
        title: "My Wallet",
      ),
    ]);
  }
}

Widget _settingWidget({
  required VoidCallback onTap,
  required String icon,
  required String title,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.sp),
      color: ColorManager.third,
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.h,
      ),
      child: Row(
        children: [
          Image.asset(
            height: 3.h,
            width: 4.w,
            icon,
          ),
          Text(
            title,
            style: TextStyleManager.getCaptionStyle(),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_rounded,
          )
        ],
      ),
    ),
  );
}

Widget _appBar(
  BuildContext context,
  String imageProfileUrl,
) {
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      CustomAppBar(
        blendMode: BlendMode.exclusion,
        backgroundImage: "assets/images/app_bar_backgrounds/4.webp",
        height: 32.h,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 2.h,
          ),
          child: CircleAvatar(
            radius: 50.sp,
            backgroundColor: ColorManager.grey3,
            backgroundImage: NetworkImage(imageProfileUrl),
          ),
        ),
      ),
    ],
  );
}
