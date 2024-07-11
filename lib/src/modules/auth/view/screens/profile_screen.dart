import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawihub/src/modules/auth/data/models/owner.dart';
import 'package:hawihub/src/modules/auth/data/models/player.dart';
import 'package:hawihub/src/modules/auth/data/models/user.dart';
import 'package:hawihub/src/modules/auth/data/models/user.dart';
import 'package:hawihub/src/modules/auth/view/screens/add_feedback_for_user.dart';
import 'package:hawihub/src/modules/auth/view/screens/rates_screen.dart';
import 'package:hawihub/src/modules/auth/view/widgets/auth_app_bar.dart';
import 'package:hawihub/src/modules/auth/view/widgets/people_rate_builder.dart';
import 'package:hawihub/src/modules/main/view/widgets/shimmers/place_holder.dart';
import 'package:hawihub/src/modules/main/view/widgets/shimmers/shimmer_widget.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/color_manager.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  final int id;
  final String userType;

  const ProfileScreen({super.key, required this.id, required this.userType});

  @override
  Widget build(BuildContext context) {
    AuthBloc bloc = AuthBloc.get(context);
    User? user;
    if(id != ConstantsManager.userId) {
      bloc.add(GetProfileEvent(id, userType));
    }else{
      user = ConstantsManager.appUser;
    }
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is GetProfileSuccessState) {
        user = state.user;
      }
      if (state is UploadNationalIdSuccessState) {
        context.pop();
        bloc.add(GetProfileEvent(id, userType));
        defaultToast(msg: S.of(context).idCardUploaded);
        context.pop();
      } else if (state is UploadNationalIdErrorState) {
        context.pop();
        errorToast(msg: handleResponseTranslation(state.error, context));
      }
      if (state is UploadNationalIdLoadingState) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: CircularProgressIndicator()),
                ],
              ),
            );
          },
        );
      }
    }, builder: (context, state) {
      if (user == null) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      AuthAppBar(
                        context: context,
                        user: user!,
                        title: S.of(context).profile,
                      ),
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
                        user!.userName,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _emailConfirmed(
                          authBloc: bloc,
                          user: user!,
                          context: context,
                          state: state),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    });
  }
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

Widget _seeAll(VoidCallback onTap, BuildContext context) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Text(
          S.of(context).seeAll,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: ColorManager.golden,
          ),
        ),
        Icon(
          Icons.arrow_forward_rounded,
          color: ColorManager.golden,
          size: 18.sp,
        ),
      ],
    ),
  );
}

Widget _emailConfirmed({
  required User user,
  required BuildContext context,
  required AuthState state,
  required AuthBloc authBloc,
}) {
  if (user.proofOfIdentityUrl == null && user.approvalStatus == 0) {
    return _notVerified(authBloc);
  } else if (user.approvalStatus == 0) {
    return _pending(context, S.of(context).identificationPending);
  } else if (user.approvalStatus == 1) {
    return _verified(
      user: user,
      authBloc: authBloc,
      context: context,
      state: state,
    );
  } else {
    return _rejectedAndTryAgain(context, S.of(context).rejectIdCard, authBloc);
  }
}

Widget _notVerified(AuthBloc bloc) {
  File? imagePicked;
  return BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) {
      if (state is AddImageSuccessState) {
        if (state.imagePicked != null) {
          imagePicked = state.imagePicked;
        }
      }
      if (state is DeleteImageState) {
        imagePicked = null;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            S.of(context).mustVerifyAccount,
            style: TextStyleManager.getSecondarySubTitleStyle(),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            S.of(context).addIdCard,
            style: TextStyleManager.getSubTitleStyle(),
          ),
          SizedBox(
            height: 3.h,
          ),
          InkWell(
            onTap: () {
              bloc.add(AddImageEvent());
            },
            child: Stack(
              children: [
                Container(
                    padding: EdgeInsetsDirectional.all(25.sp),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: ColorManager.black),
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: imagePicked != null
                        ? Text(S.of(context).fileUploaded)
                        : const Icon(Icons.file_copy_outlined)),
                if (imagePicked != null)
                  InkWell(
                    onTap: () {
                      bloc.add(DeleteImageEvent());
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5.sp),
                      child: CircleAvatar(
                          radius: 12.sp,
                          backgroundColor: ColorManager.white,
                          child: const Icon(
                            Icons.close,
                            color: ColorManager.primary,
                          )),
                    ),
                  )
              ],
            ),
          ),
          if (imagePicked != null)
            Column(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                defaultButton(
                    onPressed: () {
                      if (imagePicked != null) {
                        bloc.add(UploadNationalIdEvent(imagePicked!));
                      }
                    },
                    text: S.of(context).upload,
                    fontSize: 17.sp),
              ],
            )
        ],
      );
    },
  );
}

Widget _pending(BuildContext context, String text) {
  return Column(
    children: [
      SizedBox(
        height: 10.h,
      ),
      Text(
        text,
        style: TextStyleManager.getSecondarySubTitleStyle(),
      ),
    ],
  );
}

Widget _rejectedAndTryAgain(BuildContext context, String text, AuthBloc bloc) {
  return Column(
    children: [
      SizedBox(
        height: 10.h,
      ),
      Text(
        text,
        style: TextStyleManager.getSecondarySubTitleStyle(),
      ),
      _notVerified(bloc)
    ],
  );
}

Widget _verified({
  required User user,
  required BuildContext context,
  required AuthState state,
  required AuthBloc authBloc,
}) {
  bool isPlayer = false;
  if (user is Player) {
    isPlayer = true;
  }
  return Column(children: [
    SizedBox(
      height: 2.h,
    ),
    if (isPlayer)
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _pentagonalWidget(
            (user as Player).games,
            S.of(context).games,
          ),
          SizedBox(
            width: 5.w,
          ),
          _pentagonalWidget(
            (user).bookings,
            S.of(context).booking,
          ),
        ],
      ),
    SizedBox(
      height: 2.h,
    ),
    Text(
      user.rate.toStringAsFixed(1),
      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    ),
    RatingBar.builder(
      initialRating: user.rate,
      minRating: 1,
      itemSize: 25.sp,
      direction: Axis.horizontal,
      ignoreGestures: true,
      allowHalfRating: true,
      itemPadding: EdgeInsets.zero,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: ColorManager.golden,
      ),
      onRatingUpdate: (rating) {},
    ),
    SizedBox(
      height: 3.h,
    ),
    user.feedbacks.isEmpty
        ? Container()
        : Column(
            children: [
              Row(
                children: [
                  Text(
                    S.of(context).peopleRate,
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  _seeAll(() {
                    context.pushWithTransition(RatesScreen(
                      user: user,
                    ));
                  }, context)
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => PeopleRateBuilder(
                  context: context,
                  feedBack: user.feedbacks[index],
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 2.h,
                ),
                itemCount: user.feedbacks.take(2).length,
              ),
            ],
          ),
    SizedBox(
      height: 2.h,
    ),
    if (ConstantsManager.appUser!.ownerReservatation.contains(user.id))
      defaultButton(
          onPressed: () {
            context.pushWithTransition(
                AddFeedbackForUser(user: user, authBloc: authBloc));
          },
          text: S.of(context).addFeedback,
          fontSize: 17.sp),
    SizedBox(
      height: 2.h,
    ),
  ]);
}
