import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/modules/auth/presentation/widgets/widgets.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                _appBar(context),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 5.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Amr Salah",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _pentagonalWidget(
                      50,
                      "Games",
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    _pentagonalWidget(
                      30,
                      "Booking",
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "4.5",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                RatingBar.builder(
                  initialRating: 4.5,
                  minRating: 1,
                  itemSize: 25.sp,
                  direction: Axis.horizontal,
                  ignoreGestures: true,
                  allowHalfRating: true,
                  itemPadding: EdgeInsets.zero,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Text(
                      "People Rate",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    _seeAll(() {})
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 1.h,),
                        Container(
                          height: 12.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.sp),
                              border: Border.all()),
                          child: Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 3.w, vertical: 1.h),
                            child: Row(children: [
                              CircleAvatar(
                                radius: 20.sp,
                                backgroundColor: ColorManager.grey3,
                                backgroundImage: const NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqHvg7s5oXlmfkuIlhEw2M15jed1xxcAg6IZTcSikEbg&s"),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Expanded(
                                child: Text(
                                    "Success attrats there is sona dflskf aslkdmsa  kalas kslak ",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: ColorManager.black.withOpacity(0.5),
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 5.w,
                      top: -1.h,
                      child: Container(
                        padding: EdgeInsets.only(top: 1.h,bottom: 1.h, left: 4.w, right: 3.w),
                        color: Colors.white,
                        child:Row(
                          children: [
                            Text(
                              "Amr Salah",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500),
                            ),
                            RatingBar.builder(
                              initialRating: 4.5,
                              minRating: 1,
                              itemSize: 10.sp,
                              direction: Axis.horizontal,
                              ignoreGestures: true,
                              allowHalfRating: true,
                              itemPadding: EdgeInsets.zero,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "My Wallet",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                _walletWidget(() {}, "500"),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _walletWidget(VoidCallback onTap, String wallet) {
  return Container(
    height: 5.h,
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xff757575),
      borderRadius: BorderRadius.circular(25.sp),
    ),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: 4.w,
            top: 1.h,
            bottom: 1.h,
          ),
          child: Text(
            "$wallet \$",
            style: const TextStyle(
              color: ColorManager.white,
            ),
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: onTap,
          child: Container(
            width: 25.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(25.sp),
                bottomEnd: Radius.circular(25.sp),
              ),
            ),
            child: Center(
              child: Text(
                "Add Wallet",
                style: TextStyle(
                    color: ColorManager.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget _appBar(BuildContext context) {
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
              backIcon(context),
              SizedBox(
                width: 20.w,
              ),
              Text(
                "Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorManager.white,
                  fontSize: 32.sp,
                ),
              ),
              const Spacer(),
              _editIcon(),
            ],
          ),
        ),
      ),
      CircleAvatar(
        radius: 50.sp,
        backgroundColor: ColorManager.grey3,
        backgroundImage: const NetworkImage(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqHvg7s5oXlmfkuIlhEw2M15jed1xxcAg6IZTcSikEbg&s"),
      )
    ],
  );
}

Widget _editIcon() {
  return CircleAvatar(
    radius: 12.sp,
    backgroundColor: ColorManager.white,
    child: Image.asset(
      "assets/images/icons/edit.webp",
      height: 3.h,
      width: 4.w,
    ),
  );
}

Widget _pentagonalWidget(int number, String text) {
  return Stack(
    alignment: AlignmentDirectional.center,
    children: [
      ClipPath(
        clipper: TriangleClipper(),
        child: Container(
          width: 30.w,
          height: 15.h,
          color: ColorManager.black,
        ),
      ),
      ClipPath(
        clipper: TriangleClipper(),
        child: Container(
          width: 29.w,
          height: 14.5.h,
          color: ColorManager.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  number.toString(),
                  maxLines: 1,
                  style: TextStyle(
                    color: ColorManager.primary,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: ColorManager.grey3,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height * .7);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height * .7);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}

Widget _seeAll(VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Text(
          "See all",
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xffFFC107),
          ),
        ),
        Icon(
          Icons.arrow_forward_rounded,
          color: const Color(0xffFFC107),
          size: 18.sp,
        ),
      ],
    ),
  );
}
