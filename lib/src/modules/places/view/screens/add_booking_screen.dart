import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/error/remote_error.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawihub/src/modules/places/bloc/place__bloc.dart';
import 'package:hawihub/src/modules/places/data/models/day.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../data/models/booking.dart';

class AddBookingScreen extends StatefulWidget {
  final int placeId;
  const AddBookingScreen({super.key, required this.placeId});

  @override
  State<AddBookingScreen> createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 0, minute: 0);
  List<Booking> bookings = [];

  @override
  void initState() {
    print("place id : ${widget.placeId}");
    _fetchBookings();
    super.initState();
  }

  Future<void> _fetchBookings() async {
      PlaceBloc.get().add(GetPlaceBookingsEvent(widget.placeId));
  }

  Future<void> _selectStartTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: startTime,
      cancelText: S.of(context).cancel,
      confirmText: S.of(context).confirm,
    );
    if (pickedTime != null) {
      setState(() {
        startTime = pickedTime;
      });
    }
  }

  Future<void> _selectEndTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: endTime,
      cancelText: S.of(context).cancel,
      confirmText: S.of(context).confirm,
    );
    if (pickedTime != null) {
      setState(() {
        endTime = pickedTime;
      });
    }
  }

  Future<void> _makeBooking() async {
    DateTime start = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, startTime.hour, startTime.minute  );
    DateTime end = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, endTime.hour, endTime.minute);
    for (Booking booking in bookings) {
      // Check if the new booking overlaps with any existing booking
      if ((start.isBefore(booking.endTime) && end.isAfter(booking.startTime)) ||
          (start.isAtSameMomentAs(booking.startTime) && end.isAfter(booking.startTime)) ||
          (end.isAtSameMomentAs(booking.endTime) && start.isBefore(booking.endTime))) {
        errorToast(msg: S.of(context).bookingConflict);
        return;
      }
    }
    for (Day day in PlaceBloc.get().currentPlace!.workingHours ?? []) {
      if (!day.isBookingAllowed(start, end)) {
        errorToast(msg: S.of(context).bookingConflict);
        return;
      }

    }
    // Add the booking to the list (simulate the addition)
    setState(() {
      double reservationPrice = PlaceBloc.get().currentPlace!.price * (end.difference(start).inMinutes / 60);
     if (ConstantsManager.appUser!.myWallet < reservationPrice) {
       errorToast(msg: S.of(context).noEnoughBalance);
     }
     else {
       PlaceBloc.get().add(AddBookingEvent( Booking(startTime: start, endTime: end ,  reservationPrice:  reservationPrice ) , placeId: widget.placeId  ,));
     }
    });


  }

  @override
  Widget build(BuildContext context) {
    print("bookings: ${bookings.map((e) => "start: ${e.startTime}, end: ${e.endTime}").toString()}");
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(
                    actions: [
                      SizedBox(
                        height: 5.h,
                      )
                    ],
                    height: 33.h,
                    opacity: .15,
                    backgroundImage: "assets/images/app_bar_backgrounds/5.webp",
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: SizedBox(
                        height: 7.h,
                        child: Text(
                          S.of(context).save,
                          style: TextStyleManager.getAppBarTextStyle(),
                        ),
                      ),
                    ),
                  ),

                  BlocListener<PlaceBloc, PlaceState>(
                    bloc: PlaceBloc.get(),
                    listener: (context, state) {

                      if (state is GetPlaceBookingsSuccess) {
                        setState(() {
                          debugPrint(state.bookings.map((e) => "start: ${e.startTime}, end: ${e.endTime}").toString());
                          bookings = state.bookings;

                        });
                      }
                      if (state is PlaceError) {
                        errorToast(msg: ExceptionManager(state.exception).translatedMessage());
                      }
                      if (state is SendBookingRequestSuccess) {
                        defaultToast(msg: S.of(context).bookingSuccess);
                        context.pop();
                      }
                    },
                    child: BlocBuilder<  PlaceBloc, PlaceState>(
                      bloc: PlaceBloc.get(),
                      builder: (context, state) {
                        return state is GetPlaceBookingsLoading ? const Center(child: CircularProgressIndicator()) : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50.h,
                                child: Stack(
                                  children: [
                                    Card(
                                      color: ColorManager.white,
                                      elevation: 5,
                                      child: Column(
                                        children: [
                                          Container(
                                            color: ColorManager.primary,
                                            height: 10.h,
                                            width: double.infinity,
                                            child: Align(
                                              alignment: AlignmentDirectional.bottomStart,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TitleText(
                                                  color: ColorManager.white,
                                                  DateFormat.yMMMMEEEEd().format(selectedDate),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: CalendarDatePicker(
                                              initialCalendarMode: DatePickerMode.day,
                                              currentDate: selectedDate,
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.now().add(const Duration(days: 365)),
                                              initialDate: selectedDate,
                                              onDateChanged: (DateTime value) {
                                                setState(() {
                                                  selectedDate = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                                width: 90.w,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 43.w,
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SubTitle(S.of(context).from),
                                              FittedBox(
                                                child: TimePickerDialog(
                                                  initialTime: startTime,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Positioned.fill(child: InkWell(onTap: _selectStartTime))
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: 43.w,
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SubTitle(S.of(context).to),
                                              FittedBox(
                                                child: TimePickerDialog(
                                                  initialTime: endTime,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Positioned.fill(child: InkWell(onTap: _selectEndTime))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<PlaceBloc, PlaceState>(
            bloc: PlaceBloc.get(),
            builder: (context, state) {
              return state is GetPlaceBookingsLoading
                  ? const SizedBox()
                  : Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: DefaultButton(
                    isLoading: state is SendBookingRequestLoading,
                    text: S.of(context).save,
                    onPressed: () {
                      _makeBooking();
                    }),
              );
            },
          )
        ],
      ),
    );
  }
}
