import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Widget child;
  final List<Widget>? actions;
  final double height;
  final String? backgroundImage;

  const CustomAppBar({
    super.key,
    required this.child,
    required this.height,
    this.backgroundImage,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      child: ClipPath(
        clipper: CustomAppBarClipper(),
        child: Container(
          decoration: BoxDecoration(
            image: backgroundImage != null
                ? DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(backgroundImage!),
                  )
                : null,
            color: Colors.green,
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
    // path.quadraticBezierTo(
    //   size.width * .75,
    //   size.height * .90,
    //   size.width,
    //   size.height,
    // );
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
