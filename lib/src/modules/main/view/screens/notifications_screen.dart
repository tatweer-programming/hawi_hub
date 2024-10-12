import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/dummy/dummy_data.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/utils/styles_manager.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit cubit = MainCubit.get()..getNotifications();

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
            child: BlocBuilder<MainCubit, MainState>(
              bloc: cubit,
              builder: (context, state) {
                return Skeletonizer(
                  justifyMultiLineText: false,
                  ignorePointers: false,
                  ignoreContainers: false,
                  effect: const PulseEffect(),
                  enabled: state is GetNotificationsLoading,
                  child: cubit.notifications.isEmpty &&
                          state is! GetNotificationsLoading
                      ? Center(
                          child: SubTitle(S.of(context).noAlerts),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => NotificationWidget(
                            notification: state is GetNotificationsLoading
                                ? dummyNotifications[index]
                                : cubit.notifications[index],
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 2.h,
                          ),
                          itemCount: state is GetNotificationsLoading
                              ? dummyNotifications.length
                              : cubit.notifications.length,
                        ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
