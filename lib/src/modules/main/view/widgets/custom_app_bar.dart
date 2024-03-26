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
  const CustomAppBar({
    super.key,
    required this.child,
    required this.height,
    this.backgroundImage,
    this.actions,
    this.opacity,
    this.blendMode,
    this.color,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(children: actions ?? []),
              SizedBox(height: 10.sp),
              Expanded(child: Center(child: child)),
              SizedBox(height: 10.sp),
            ],
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
    path.lineTo(0, size.height * .85);
    path.quadraticBezierTo(
      size.width * .125,
      size.height * .75,
      size.width * .25,
      size.height * .75,
    );
    path.quadraticBezierTo(
      size.width * .5,
      size.height * .75,
      size.width * .75,
      size.height * .90,
    );
    path.quadraticBezierTo(
      size.width * .875,
      size.height * .99,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
