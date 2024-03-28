import 'package:flutter/material.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawihub/src/modules/main/view/widgets/shimmers/notification_shimmers.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/utils/styles_manager.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          CustomAppBar(
            //color:  ,
            opacity: .1,
            // blendMode: BlendMode.saturation,
            backgroundImage: "assets/images/app_bar_backgrounds/2.webp",
            height: 35.h,
            actions: const [
              //   Icon(Icons.notifications),
            ],
            child: Text(
              style: TextStyleManager.getAppBarTextStyle(),
              S.of(context).notifications,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: const VerticalNotificationsShimmer(),
          ),
        ],
      )),
    );
  }
}
