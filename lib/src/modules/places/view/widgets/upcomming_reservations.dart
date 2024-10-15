import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/apis/api.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/images_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/dummy/dummy_data.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/games/data/models/game.dart';
import 'package:hawihub/src/modules/games/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/places/bloc/place_bloc.dart';
import 'package:hawihub/src/modules/places/data/models/booking.dart';
import 'package:hawihub/src/modules/places/view/widgets/components.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/models/place.dart';

class UpComingReservationsList extends StatelessWidget {
  const UpComingReservationsList({super.key});

  @override
  Widget build(BuildContext context) {
    PlaceBloc placeBloc = PlaceBloc.get();

    return BlocConsumer<PlaceBloc, PlaceState>(
      listener: (context, state) {
        if (state is GetUpcomingReservationsSuccess) {
          debugPrint(state.reservations.toString());
        }
      },
      builder: (context, state) {
        return Skeletonizer(
          justifyMultiLineText: false,
          ignorePointers: false,
          ignoreContainers: false,
          containersColor: ColorManager.grey1,
          effect: const PulseEffect(),
          enabled: state is GetUpcomingReservationsLoading,
          child: placeBloc.placeBookings.isEmpty &&
                  state is! GetUpcomingReservationsLoading
              ? const EmptyView()
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 2.h,
                  ),
                  itemCount: state is GetUpcomingReservationsLoading
                      ? dummyReservations.length.clamp(0, 3)
                      : placeBloc.placeBookings.length,
                  itemBuilder: (context, index) {
                    return UpcomingReservationCard(
                      reservation: state is GetUpcomingReservationsLoading
                          ? dummyReservations[index]
                          : placeBloc.placeBookings[index],
                    );
                  },
                ),
        );
      },
    );
  }
}

class UpcomingReservationCard extends StatelessWidget {
  final Booking reservation;

  const UpcomingReservationCard({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    PlaceBloc placeBloc = PlaceBloc.get();

    void _showCancelDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.of(context).warning),
            content: Text(
              S.of(context).cancelReservationWarning,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // غلق الـ dialog
                },
                child: Text(
                  S.of(context).goBack,
                  style: TextStyleManager.getRegularStyle(),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(ColorManager.white),
                  backgroundColor:
                      MaterialStateProperty.all(ColorManager.error),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // غلق الـ dialog
                  placeBloc
                      .add(CanselReservationEvent(reservation.reservationId));
                },
                child: Text(S.of(context).cancel),
              ),
            ],
          );
        },
      );
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      height: 20.h,
      width: 85.w,
      decoration: BoxDecoration(
        color: ColorManager.grey1,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Container(
                    width: 25.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        onError: (__, _) =>
                            ColoredBox(color: ColorManager.grey1),
                        image: NetworkImage(ApiManager.handleImageUrl(
                            reservation.placeImages.first)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          Expanded(
                              flex: 1, child: SubTitle(reservation.placeName)),
                          SizedBox(height: 1.h),
                          Flexible(
                            flex: 2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.location_on_rounded, size: 15),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    reservation.placeAddress,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyleManager.getRegularStyle(
                                        color: ColorManager.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 0.5.h),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Icon(Icons.calendar_month,
                                            size: 15),
                                        const SizedBox(width: 5),
                                        Text(
                                          reservation.getDate(),
                                          style:
                                              TextStyleManager.getRegularStyle(
                                                  color: ColorManager.grey2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Icon(
                                            Icons.access_time_filled_sharp,
                                            size: 15),
                                        const SizedBox(width: 5),
                                        Text(
                                          reservation.getTime(),
                                          style:
                                              TextStyleManager.getRegularStyle(
                                                  color: ColorManager.grey2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Expanded(
                                    child: Text(
                                      "${reservation.reservationPrice} ${S.of(context).sar}",
                                      style: TextStyleManager.getRegularStyle(
                                          color: ColorManager.secondary),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 10.w,
            height: 20.h,
            color: ColorManager.error,
            child: InkWell(
              onTap: () => _showCancelDialog(context),
              // عرض التحذير قبل الإلغاء
              child: RotatedBox(
                quarterTurns: 1,
                child: BlocBuilder<PlaceBloc, PlaceState>(
                  bloc: placeBloc,
                  builder: (context, state) {
                    return Center(
                      child: state is CancelReservationLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              S.of(context).cancel,
                              style: TextStyleManager.getRegularStyle(
                                  color: ColorManager.white),
                            ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
