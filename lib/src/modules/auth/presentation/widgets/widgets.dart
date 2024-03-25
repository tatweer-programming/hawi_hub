import 'package:flutter/material.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:sizer/sizer.dart';

Widget defaultButton({
  required VoidCallback onPressed,
  required String text,
  double? height,
  double? fontSize,
}) =>
    Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(25.sp),
      ),
      child: MaterialButton(
          height: height ?? 7.h,
          minWidth: 80.w,
          color: ColorManager.primary,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: ColorManager.white,
              fontSize: fontSize,
            ),
          )),
    );

Widget authBackGround(double height) => Stack(
      children: [
        Align(
          alignment: AlignmentDirectional.topCenter,
          heightFactor: 0.9,
          child: ClipPath(
            clipper: HalfCircleCurve(height / 3),
            child: Container(
              height: height,
              width: double.infinity,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: ColorManager.grey1,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/images/auth_background.png",
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: 2.h,
            start: 2.w,
          ),
          child: Image.asset(
            "assets/images/logo2.png",
          ),
        ),
      ],
    );

mainFormField(
        {String? label,
        Icon? prefix,
        String? hint,
        IconButton? suffix,
        bool? enabled = true,
        Color? fillColor,
        String? validatorText,
        TextInputType? type,
        bool border = true,
        void Function()? suffixFunction,
        FormFieldValidator? validator,
        bool obscureText = false,
        double? width,
        TextStyle? labelStyle,
        int? maxLines,
        int? minLines,
        TextAlign? textAlign,
        required TextEditingController controller}) =>
    SizedBox(
      width: width ?? double.infinity,
      child: TextFormField(
        textAlign: textAlign ?? TextAlign.start,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: controller,
        keyboardType: type,
        enabled: enabled,
        obscureText: obscureText,
        maxLines: maxLines,
        minLines: minLines,
        style: const TextStyle(color: ColorManager.black),
        decoration: InputDecoration(
            prefixIcon: prefix,
            disabledBorder: OutlineInputBorder(
              borderSide: !border
                  ? BorderSide.none
                  : BorderSide(color: ColorManager.grey3),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            contentPadding:
                EdgeInsetsDirectional.symmetric(horizontal: 5.w, vertical: 2.h),
            focusedBorder: OutlineInputBorder(
              borderSide: !border
                  ? BorderSide.none
                  : const BorderSide(color: ColorManager.grey2),
              borderRadius: BorderRadius.circular(25.sp),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: !border
                  ? BorderSide.none
                  : const BorderSide(color: ColorManager.grey2),
              borderRadius: BorderRadius.circular(25.sp),
            ),
            errorStyle: TextStyle(color: ColorManager.error),
            fillColor: fillColor ?? ColorManager.white,
            filled: true,
            suffixIcon: suffix,
            labelText: label,
            helperText: hint,
            labelStyle: labelStyle ??
                TextStyle(color: ColorManager.grey3, fontSize: 12.sp)),
        validator: validator,
      ),
    );

class HalfCircleCurve extends CustomClipper<Path> {
  final double height;

  HalfCircleCurve(this.height);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path
      ..lineTo(0, size.height - height)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - height)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
