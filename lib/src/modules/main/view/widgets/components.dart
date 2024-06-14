import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hawihub/src/core/apis/api.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/localization_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/data/models/app_notification.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

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
              valueColor: AlwaysStoppedAnimation<Color>(textColor ?? ColorManager.white),
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
        style: isBold ? TextStyleManager.getTitleBoldStyle() : TextStyleManager.getTitleStyle());
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
        style:
            isBold ? TextStyleManager.getSubTitleBoldStyle() : TextStyleManager.getSubTitleStyle());
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
      background: Row(

        children: [
          Icon(
            Icons.mark_chat_read,
            color: ColorManager.primary,
          ),
          Spacer(),

        ],
      ),
      key: UniqueKey(),
      onDismissed:  (context) {
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
                backgroundImage: NetworkImage(ApiManager.handleImageUrl(notification.image!)),
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
      List<String>? images,
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
          borderRadius: BorderRadius.circular(22), borderSide: BorderSide(color: textColor!)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(22)),
      contentPadding: EdgeInsets.symmetric(horizontal: 1.w),
    ),
    onSelected: onChanged,
    menuHeight: 50.h,

    dropdownMenuEntries: items.map<DropdownMenuEntry<String>>(
      (String value) {
        return DropdownMenuEntry<String>(value: value, label: value ,
        leadingIcon:    images == null ? null : CircleAvatar(
            backgroundImage: NetworkImage(ApiManager.handleImageUrl(images[items.indexOf(value)])),
        ),
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
    this.color = ColorManager.white,
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
