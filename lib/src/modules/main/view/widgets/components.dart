import 'package:flutter/material.dart';
import 'package:hawihub/src/core/apis/api.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/localization_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/data/models/app_notification.dart';
import 'package:hawihub/src/modules/main/data/models/sport.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/routing/routes.dart';
import '../../../../core/utils/font_manager.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final IconData? icon;
  final double? width;
  final double? height;
  final double? radius;
  final bool isLoading;

  const DefaultButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.color,
      this.textColor,
      this.borderColor,
      this.icon,
      this.width,
      this.height,
      this.radius,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 5.h,
      decoration: BoxDecoration(
        color: color ?? ColorManager.primary,
        border: Border.all(color: borderColor ?? ColorManager.primary),
        borderRadius: BorderRadius.circular(radius ?? 10),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && !isLoading)
              Icon(
                icon,
                color: textColor ?? ColorManager.white,
              ),
            SizedBox(width: 5.sp),
            isLoading
                ? CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        textColor ?? ColorManager.white),
                  )
                : Text(text,
                    style: TextStyle(
                      color: textColor ?? ColorManager.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeightManager.bold,
                    )),
          ],
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String text;
  final bool isBold;
  final Color? color;

  const TitleText(this.text, {super.key, this.isBold = true, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: isBold
            ? TextStyleManager.getTitleBoldStyle(color: color)
            : TextStyleManager.getTitleStyle());
  }
}

class SubTitle extends StatelessWidget {
  final String text;
  final bool isBold;

  const SubTitle(
    this.text, {
    this.isBold = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: 2,
        overflow: TextOverflow.fade,
        style: isBold
            ? TextStyleManager.getSubTitleBoldStyle()
            : TextStyleManager.getSubTitleStyle());
  }
}

class OutLineContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double? radius;
  final double? height;
  final double? width;
  final Color? color;
  final Color? borderColor;

  const OutLineContainer(
      {super.key,
      required this.child,
      this.onPressed,
      this.radius,
      this.height,
      this.width,
      this.color,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? 5.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: borderColor ?? ColorManager.black,
            width: .5,
          ),
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final AppNotification notification;

  const NotificationWidget({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      background: const Row(
        children: [
          Icon(
            Icons.mark_chat_read,
            color: ColorManager.primary,
          ),
          Spacer(),
        ],
      ),
      key: UniqueKey(),
      onDismissed: (context) {
        MainCubit.get().markNotificationAsRead(notification.id);
      },
      child: Container(
        height: 10.h,
        width: 90.w,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: ColorManager.primary.withOpacity(.1),
          borderRadius: BorderRadius.circular(180),
        ),
        child: Row(
          children: [
            if (notification.image != null)
              CircleAvatar(
                radius: 5.h,
                backgroundImage: NetworkImage(
                    ApiManager.handleImageUrl(notification.image!)),
                backgroundColor: ColorManager.primary,
              ),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: Text(notification.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyleManager.getSubTitleBoldStyle())),
                      Text(
                          timeago.format(notification.dateTime!,
                              locale: LocalizationManager.getCurrentLocale()
                                  .languageCode),
                          style: TextStyleManager.getSubTitleStyle()),
                      SizedBox(width: 1.w),
                      const FittedBox(
                          child: Icon(
                        Icons.access_time,
                      )),
                      SizedBox(width: 3.w),
                    ],
                  ),
                  SizedBox(height: .5.h),
                  Text(notification.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleManager.getRegularStyle()),
                ]))
          ],
        ),
      ),
    );
  }
}

Widget dropdownBuilder(
    {required String text,
    IconData? icon,
    required Function(String? value) onChanged,
    required List<String> items,
    List<Widget>? leadingIcons,
    Color? backgroundColor = ColorManager.white,
    Color? textColor = ColorManager.black}) {
  return DropdownMenu<String>(
    // errorText: text,
    // controller: TextEditingController(),
    label: Text(text, style: TextStyle(color: textColor)),
    enableFilter: false,
    requestFocusOnTap: false,
    expandedInsets: EdgeInsets.zero,
    enableSearch: false,
    leadingIcon: Icon(
      icon ?? Icons.search,
      color: ColorManager.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: backgroundColor,
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(color: textColor!)),
      focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(22)),
      contentPadding: EdgeInsets.symmetric(horizontal: 1.w),
    ),
    onSelected: onChanged,
    menuHeight: 50.h,

    dropdownMenuEntries: items.map<DropdownMenuEntry<String>>(
      (String value) {
        return DropdownMenuEntry<String>(
          value: value,
          label: value,
          leadingIcon:
              leadingIcons == null ? null : leadingIcons[items.indexOf(value)],
        );
      },
    ).toList(),
  );
}

class CityDropdown extends StatefulWidget {
  const CityDropdown({
    super.key,
    required this.selectedCity,
    required this.onCitySelected,
    required this.cities,
    this.color = ColorManager.black,
  });

  final String selectedCity;
  final Function(String) onCitySelected;
  final List<String> cities;

  final Color color;

  @override
  State<CityDropdown> createState() => _CityDropdownState();
}

class _CityDropdownState extends State<CityDropdown> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.selectedCity,
          style: TextStyle(fontSize: 16, color: widget.color),
        ),
        const SizedBox(width: 8),
        PopupMenuButton<String>(
          iconColor: ColorManager.black,
          icon: Icon(Icons.arrow_drop_down, color: widget.color),
          onSelected: (city) => widget.onCitySelected(city),
          itemBuilder: (context) => widget.cities
              .map((city) => PopupMenuItem(
                    value: city,
                    child: Text(city),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class SportItemWidget extends StatelessWidget {
  final Sport sport;

  const SportItemWidget({super.key, required this.sport});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(Routes.exploreBySport, arguments: {"sportId": sport.id});
      },
      child: Hero(
        tag: "sport_${sport.id}",
        child: Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                ApiManager.handleImageUrl(sport.image),
              ),
              onError: (__, _) => ColoredBox(
                color: ColorManager.grey1,
              ),
              fit: BoxFit.cover,
            ),
            border: Border.all(),
            borderRadius: BorderRadius.circular(5.sp),
          ),
          child: Column(children: [
            const Spacer(),
            Container(
              width: double.maxFinite,
              color: ColorManager.black.withOpacity(0.6),
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Center(
                  child: Text(" ${sport.name} ",
                      style: TextStyleManager.getBlackContainerTextStyle()),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class SportNameWidget extends StatelessWidget {
  final String sport;
  final int sportId;

  const SportNameWidget(
      {super.key, required this.sport, required this.sportId});

  @override
  Widget build(BuildContext context) {
    return buildSportWidget(sport, context, sportId: sportId);
  }

  Widget buildSportWidget(String sport, BuildContext context,
      {required int sportId}) {
    return Container(
      height: 5.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.grey1,
      ),
      child: InkWell(
          onTap: () {
            context
                .push(Routes.exploreBySport, arguments: {"sportId": sportId});
          },
          child: Center(
              child: Text(sport,
                  style: TextStyleManager.getBlackCaptionTextStyle()))),
    );
  }
}
