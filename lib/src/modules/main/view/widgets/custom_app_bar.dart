import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/color_manager.dart';

class CustomAppBar extends StatelessWidget {
  final Widget child;
  final List<Widget>? actions;
  final double height;
  final String? backgroundImage;
  final double? opacity;
  final BlendMode? blendMode;
  final Color? color;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    required this.child,
    required this.height,
    this.backgroundImage,
    this.actions,
    this.opacity,
    this.blendMode,
    this.color,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ClipPath(
        clipper: CustomAppBarClipper(),
        child: Container(
          decoration: BoxDecoration(
            image: backgroundImage != null
                ? DecorationImage(
                    fit: BoxFit.fill,
                    opacity: opacity ?? .1,
                    colorFilter: ColorFilter.mode(
                      color ?? ColorManager.transparent,
                      blendMode ?? BlendMode.colorDodge,
                    ),
                    image: AssetImage(
                      backgroundImage!,
                    ),
                  )
                : null,
            color: ColorManager.primary,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    if (actions != null)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 2.h, right: 2.w, left: 2.w, bottom: 1.h),
                          child: Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: actions!
                                    .map((e) => Padding(
                                          padding: EdgeInsets.all(1.sp),
                                          child: e,
                                        ))
                                    .toList()),
                          ),
                        ),
                      ),
                    if (leading != null) leading!,
                  ],
                ),
                SizedBox(height: 10.sp),
                child,
                SizedBox(height: height * .3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * .87);
    path.quadraticBezierTo(
      size.width * .125,
      size.height * .77,
      size.width * .25,
      size.height * .75,
    );
    path.quadraticBezierTo(
      size.width * .5,
      size.height * .72,
      size.width * .7,
      size.height * .85,
    );
    path.quadraticBezierTo(
      size.width * .875,
      size.height * .95,
      size.width,
      size.height * .91,
    );
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class ImageAppBar extends StatelessWidget {
  final String title;
  final String imagePath;

  const ImageAppBar({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 42.h,
        width: 100.w,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                height: 42.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: ColorManager.grey1,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage(imagePath))),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.black.withOpacity(.2),
                  // gradient: RadialGradient(
                  //     tileMode: TileMode.clamp,
                  //     center: Alignment.center,
                  //     colors: [
                  //       ColorManager.black.withOpacity(0.1),
                  //       ColorManager.black.withOpacity(0.1),
                  //       ColorManager.black.withOpacity(0.1),
                  //       ColorManager.black.withOpacity(0.2),
                  //       ColorManager.black.withOpacity(0.3),
                  //       ColorManager.black.withOpacity(0.4),
                  //       ColorManager.black.withOpacity(0.5),
                  //       ColorManager.black.withOpacity(0.6),
                  //       ColorManager.black.withOpacity(0.7),
                  //       ColorManager.black.withOpacity(0.8),
                  //     ]),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: ColorManager.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
