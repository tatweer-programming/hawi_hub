import 'package:flutter/material.dart';
import 'package:flutter_animated_icon_button/flutter_animated_icon_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/apis/api.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/user_access_proxy/data_source_proxy.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/core/utils/images_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/places/bloc/place_bloc.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';
import 'package:hawihub/src/modules/places/data/models/place.dart';
import 'package:hawihub/src/modules/places/view/screens/place_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../main/view/widgets/components.dart';

class PlaceItem extends StatelessWidget {
  final Place place;

  const PlaceItem({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceScreen(placeId: place.id),
          ),
        );
      },
      child: SizedBox(
        height: 40.h,
        width: 70.w,
        child: Card(
          color: ColorManager.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorManager.grey1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                  child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Hero(
                      tag: place.id,
                      transitionOnUserGestures: true,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          image: DecorationImage(
                            onError: (__, _) =>
                                ColoredBox(color: ColorManager.grey1),
                            image: NetworkImage(
                                ApiManager.handleImageUrl(place.images.first)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SubTitle(
                              place.name,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              place.address,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyleManager.getCaptionStyle(),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              "${place.price} ${S.of(context).sar}/hour",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyleManager.getCaptionStyle(),
                            )
                          ],
                        ),
                      ))
                ],
              )),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: FavoriteIconButton(
                  placeId: place.id,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteIconButton extends StatefulWidget {
  final int placeId;

  final Color color;

  const FavoriteIconButton(
      {Key? key, required this.placeId, this.color = ColorManager.grey2})
      : super(key: key);

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isFavorite = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    if (ConstantsManager.appUser != null) {
      if (ConstantsManager.appUser!.favoritePlaces.contains(widget.placeId)) {
        isFavorite = true;
      }
    }
    if (isFavorite) {
      controller.forward();
    }
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlaceBloc, PlaceState>(
      listener: (context, state) {
        if (state is AddPlaceToFavouritesError) {
          controller.reverse();
        } else if (state is DeletePlaceFromFavouritesError) {
          controller.forward();
        } else if (state is AddPlaceToFavouritesSuccess ||
            state is DeletePlaceFromFavouritesSuccess) {}
      },
      child: IconButton(
          onPressed: () {
            PlaceBloc bloc = PlaceBloc.get();
            if (!isFavorite) {
              controller.forward();
              UserAccessProxy(bloc, AddPlaceToFavoriteEvent(widget.placeId))
                  .execute([AccessCheckType.login]);
            } else {
              controller.reverse();
              UserAccessProxy(
                      bloc, DeletePlaceFromFavoriteEvent(widget.placeId))
                  .execute([AccessCheckType.login]);
            }
          },
          icon: TapParticle(
            particleCount: 5,
            particleLength: 10,
            color: ColorManager.error,
            syncAnimation: controller,
            duration: const Duration(milliseconds: 300),
            child: TapFillIcon(
              animationController: controller,
              borderIcon: Icon(
                size: 25.sp,
                Icons.favorite,
                color: widget.color,
              ),
              fillIcon: Icon(
                Icons.favorite,
                size: 25.sp,
                color: ColorManager.error,
              ),
            ),
          )),
    );
  }
}

class AnimatedIconButton extends StatefulWidget {
  final Place place;

  const AnimatedIconButton({super.key, required this.place});

  @override
  _AnimatedIconButtonState createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    if (ConstantsManager.appUser != null) {
      isFavorite =
          ConstantsManager.appUser!.favoritePlaces.contains(widget.place.id);
    }

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  Future<void> toggleFavorite() async {
    try {
      setState(() {
        isFavorite = !isFavorite;
      });

      if (isFavorite) {
        UserAccessProxy(
            PlaceBloc.get(), AddPlaceToFavoriteEvent(widget.place.id));
        _controller.forward();
      } else {
        UserAccessProxy(
            PlaceBloc.get(), DeletePlaceFromFavoriteEvent(widget.place.id));
        _controller.reverse();
      }
    } catch (e) {
      // لو في ايرور، يرجع الحالة القديمة مع الانيميشن
      setState(() {
        isFavorite = !isFavorite;
      });
      if (isFavorite) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30.sp,
      icon: AnimatedIcon(
        icon: AnimatedIcons.add_event,
        progress: _controller,
        color: isFavorite ? Colors.red : Colors.white,
      ),
      onPressed: toggleFavorite,
    );
  }
}

class SportItem extends StatelessWidget {
  final String sportName;
  final IconData sportIcon;

  const SportItem(
      {super.key, required this.sportName, required this.sportIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      height: 10.h,
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(5.sp),
      ),
      child: Column(children: [
        Icon(
          sportIcon,
        ),
        Text(sportName)
      ]),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Center(child: SubTitle(S.of(context).noItemsFound)),
    );
  }
}

class FeedBackWidget extends StatelessWidget {
  final AppFeedBack feedBack;

  const FeedBackWidget({super.key, required this.feedBack});

  @override
  Widget build(BuildContext context) {
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
                    backgroundImage: NetworkImage(ApiManager.handleImageUrl(
                        feedBack.userImageUrl ?? ImagesManager.defaultProfile)),
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
                  feedBack.userName ?? "",
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
}
// class AnimatedIconButton extends StatefulWidget {
//   @override
//   _AnimatedIconButtonState createState() => _AnimatedIconButtonState();
// }
//
// class _AnimatedIconButtonState extends State<AnimatedIconButton>
//     with SingleTickerProviderStateMixin {
//   bool isFavorite = false;
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(seconds: 1),
//       vsync: this,
//     );
//     _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
//   }
//
//   Future<void> toggleFavorite() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       if (!isFavorite) {
//         await addToFavorites(); // حاول تضيف المكان للمفضلة
//       } else {
//         await removeFromFavorites(); // حاول تحذف المكان من المفضلة
//       }
//
//       // لو مفيش مشكلة، عكس الحالة
//       setState(() {
//         isFavorite = !isFavorite;
//       });
//
//       if (isFavorite) {
//         _controller.forward();
//       } else {
//         _controller.reverse();
//       }
//     } catch (e) {
//       // في حالة الخطأ، عكس الانيمشن أياً كان وضعه
//       _controller.reverse();
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   Future<void> addToFavorites() async {
//     // هنا من المفترض إنك تضيف الـ Logic بتاع الإضافة
//     await Future.delayed(Duration(seconds: 1)); // محاكاة التأخير
//     throw Exception("Error adding to favorites"); // استبدلها بالـ API أو أي logic تاني
//   }
//
//   Future<void> removeFromFavorites() async {
//     // هنا من المفترض إنك تضيف الـ Logic بتاع الحذف
//     await Future.delayed(Duration(seconds: 1)); // محاكاة التأخير
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       iconSize: 50,
//       icon: AnimatedBuilder(
//         animation: _animation,
//         builder: (context, child) {
//           return Icon(
//             Icons.favorite,
//             color: Color.lerp(Colors.grey, Colors.red, _animation.value),
//           );
//         },
//       ),
//       onPressed: isLoading ? null : toggleFavorite,
//     );
//   }
// }
