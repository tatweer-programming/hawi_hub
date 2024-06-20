import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/modules/auth/data/models/user.dart';
import 'package:hawihub/src/modules/auth/data/models/user.dart';
import 'package:hawihub/src/modules/auth/view/widgets/auth_app_bar.dart';
import 'package:hawihub/src/modules/auth/view/widgets/people_rate_builder.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../main/view/widgets/custom_app_bar.dart';
import '../widgets/widgets.dart';

class RatesScreen extends StatelessWidget {
  final User user;

  const RatesScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AuthAppBar(
            context: context,
            user: user,
            title: S.of(context).rates,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            user.userName,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 5.w,
            ),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                S.of(context).peopleRate,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (user.feedbacks.isNotEmpty)
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 5.w,
                ),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => PeopleRateBuilder(
                          context: context,
                          feedBack: user.feedbacks[index],
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 2.h,
                        ),
                    itemCount: user.feedbacks.length),
              ),
            ),
        ],
      ),
    );
  }
}

Widget _appBar(
  BuildContext context,
  String? profilePictureUrl,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              backIcon(
                context: context,
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(
                S.of(context).rates,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorManager.white,
                  fontSize: 32.sp,
                ),
              ),
            ],
          ),
        ),
      ),
      if (profilePictureUrl != null)
        CircleAvatar(
          radius: 50.sp,
          backgroundColor: ColorManager.grey3,
          backgroundImage: NetworkImage(profilePictureUrl),
        ),
      if (profilePictureUrl == null)
        CircleAvatar(
          radius: 50.sp,
          backgroundColor: ColorManager.grey3,
          backgroundImage: const AssetImage("assets/images/icons/user.png"),
        ),
    ],
  );
}
