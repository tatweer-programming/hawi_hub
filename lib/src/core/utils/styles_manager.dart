import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:sizer/sizer.dart';

import 'font_manager.dart';

class TextStyleManager {
  static TextStyle getRegularStyle() {
    return TextStyle(
      color: ColorManager.black,
      fontSize: FontSizeManager.s12,
      fontWeight: FontWeightManager.regular,
    );
  }

  static TextStyle getTitleBoldStyle() {
    return TextStyle(
      color: ColorManager.black,
      fontSize: FontSizeManager.s16,
      fontWeight: FontWeightManager.bold,
    );
  }

  static TextStyle getButtonTextStyle() {
    return TextStyle(
      color: ColorManager.white,
      fontSize: FontSizeManager.s16,
      fontWeight: FontWeightManager.bold,
    );
  }

  static TextStyle getTitleStyle() {
    return TextStyle(
      color: ColorManager.black,
      fontSize: FontSizeManager.s16,
      fontWeight: FontWeightManager.regular,
    );
  }

  static TextStyle getSubTitleStyle() {
    return TextStyle(
      color: ColorManager.black,
      fontSize: FontSizeManager.s14,
      fontWeight: FontWeightManager.regular,
    );
  }

  static TextStyle getSubTitleBoldStyle() {
    return TextStyle(
      color: ColorManager.black,
      fontSize: FontSizeManager.s15,
      fontWeight: FontWeightManager.bold,
    );
  }

  static TextStyle getGoldenRegularStyle() {
    return TextStyle(
      color: ColorManager.golden,
      fontSize: FontSizeManager.s11,
      fontWeight: FontWeightManager.regular,
    );
  }

  static TextStyle getSecondaryRegularStyle() {
    return TextStyle(
      color: ColorManager.secondary,
      fontSize: FontSizeManager.s11,
      fontWeight: FontWeightManager.regular,
    );
  }

  static TextStyle getCaptionStyle() {
    return TextStyle(fontSize: 13.sp, color: ColorManager.grey2);
  }

  static TextStyle getBlackCaptionTextStyle() {
    return TextStyle(
        fontSize: 11.sp, color: ColorManager.black, fontWeight: FontWeightManager.bold);
  }

  static TextStyle getBlackContainerTextStyle() {
    return TextStyle(
      fontSize: 12.sp,
      color: ColorManager.white,
    );
  }
}
