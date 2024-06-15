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
import 'package:hawihub/src/modules/auth/data/models/player.dart';
import 'package:hawihub/src/modules/auth/view/screens/rates_screen.dart';
import 'package:hawihub/src/modules/auth/view/widgets/auth_app_bar.dart';
import 'package:hawihub/src/modules/main/view/widgets/shimmers/place_holder.dart';
import 'package:hawihub/src/modules/main/view/widgets/shimmers/shimmer_widget.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/color_manager.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  final int id;

  const ProfileScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    AuthBloc bloc = AuthBloc.get(context);
    bloc.add(GetProfileEvent(id));
    Player? player;
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is GetProfileSuccessState) {
        player = state.player;
      }
      if (state is UploadNationalIdSuccessState) {
        context.pop();
        bloc.add(GetProfileEvent(id));
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
      return FutureBuilder(
        future: _fetchProfile(bloc, id),
        builder: (context, snapshot) {
          if (player == null) {
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
                            player: player!,
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
                            player!.userName,
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
                                player!.games,
                                S.of(context).games,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              _pentagonalWidget(
                                player!.bookings,
                                S.of(context).booking,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          _emailConfirmed(
                              bloc: bloc,
                              player: player!,
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
        },
      );
    });
  }
}

Future<void> _fetchProfile(AuthBloc bloc, int id) async {
  bloc.add(GetProfileEvent(id));
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

Widget _peopleRateBuilder(AppFeedBack feedBack, BuildContext context) {
  return Stack(
    children: [
      Column(
        children: [
          SizedBox(
            height: 1.h,
          ),
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
                  backgroundImage: NetworkImage(feedBack.userImageUrl!),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: Text(feedBack.comment ?? S.of(context).noComment,
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
          padding: EdgeInsetsDirectional.symmetric(
            vertical: 1.h,
            horizontal: 2.w,
          ),
          color: Colors.white,
          child: Row(
            children: [
              Text(
                feedBack.userName,
                style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.green,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 1.w),
              RatingBar.builder(
                initialRating: feedBack.rating,
                minRating: 1,
                itemSize: 10.sp,
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
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _emailConfirmed({
  required Player player,
  required BuildContext context,
  required AuthState state,
  required AuthBloc bloc,
}) {
  if (player.proofOfIdentityUrl == null && player.approvalStatus == 0) {
    return _notVerified(bloc);
  } else if (player.approvalStatus == 0) {
    return _pending(context, S.of(context).identificationPending);
  } else if (player.approvalStatus == 1) {
    return _verified(
      player: player,
      context: context,
      state: state,
    );
  } else {
    return _rejectedAndTryAgain(context, S.of(context).rejectIdCard, bloc);
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
          Row(
            children: [
              Expanded(
                child: Text(
                  S.of(context).addRequiredPdf,
                  style: TextStyleManager.getSubTitleStyle(),
                ),
              ),
              IconButton(
                  onPressed: () {
                    bloc.add(OpenPdfEvent());
                  },
                  icon: const Icon(Icons.picture_as_pdf))
            ],
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
  required Player player,
  required BuildContext context,
  required AuthState state,
}) {
  return Column(children: [
    SizedBox(
      height: 2.h,
    ),
    Text(
      player.rate!.remainder(1).toString(),
      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    ),
    RatingBar.builder(
      initialRating: player.rate!,
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
      height: 2.h,
    ),
    player.feedbacks.isEmpty
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
                      player: player,
                    ));
                  }, context)
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              state is GetProfileLoadingState
                  ? ShimmerWidget(
                      height: 13.h,
                      width: double.infinity,
                      placeholder: ShimmerPlaceHolder(
                        borderRadius: 15.sp,
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          _peopleRateBuilder(player.feedbacks[index], context),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 2.h,
                          ),
                      itemCount: player.feedbacks.take(2).length),
            ],
          ),
    SizedBox(
      height: 2.h,
    ),
    Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        S.of(context).myWallet,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
      ),
    ),
    SizedBox(
      height: 2.h,
    ),
    if (ConstantsManager.userId == player.id)
      walletWidget(() {}, player.myWallet.toString()),
  ]);
}
