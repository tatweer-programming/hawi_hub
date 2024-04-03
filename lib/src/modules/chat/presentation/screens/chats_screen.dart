import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/auth/presentation/widgets/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../main/view/widgets/custom_app_bar.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // chatBloc.add(GetChatsEvent());
      },
      child: Scaffold(
        body: Column(
          children: [
            _appBar(context),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => _chatWidget(text: "Ahmed", onTap: () {}),
                  itemCount: 2),
            ),
            SizedBox(
              height: 1.h,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _appBar(
  BuildContext context,
) {
  return CustomAppBar(
    blendMode: BlendMode.exclusion,
    backgroundImage: "assets/images/app_bar_backgrounds/5.webp",
    height: 30.h,
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 5.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          backIcon(context),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Text(
              "Conversations",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorManager.white,
                fontSize: 30.sp,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _chatWidget({required String text, required VoidCallback onTap}) =>
    Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 7.w,vertical: 2.h,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ColorManager.grey3,
            radius: 22.sp,
          ),
          SizedBox(
            width: 4.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Name",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      "05:00 PM",
                      style: TextStyleManager.getCaptionStyle().copyWith(
                        fontSize: 10.sp
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        "Message welcome Ahmed Welcome Ahmed",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyleManager.getRegularStyle(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.symmetric(
                        vertical: 0.4.h,
                        horizontal: 1.5.w,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.golden,
                        borderRadius: BorderRadius.circular(5.sp),
                      ),
                      child: Text(
                        "3",
                        style: TextStyleManager.getRegularStyle().copyWith(
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
