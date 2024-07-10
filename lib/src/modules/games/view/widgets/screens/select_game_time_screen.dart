import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawihub/src/modules/places/bloc/place_bloc.dart';
import 'package:hawihub/src/modules/places/data/models/booking.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class SelectGameTimeScreen extends StatefulWidget {
  final int placeId;

  const SelectGameTimeScreen({super.key, required this.placeId});

  @override
  State<SelectGameTimeScreen> createState() => _SelectGameTimeScreenState();
}

class _SelectGameTimeScreenState extends State<SelectGameTimeScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 0, minute: 0);
  List<Booking> bookings = [];

  @override
  void initState() {
    super.initState();
    print("place id : ${widget.placeId}");
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    PlaceBloc.get().add(GetPlaceBookingsEvent(widget.placeId));
  }

  Future<void> _selectTime({required bool isStartTime}) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime ? startTime : endTime,
      cancelText: S.of(context).cancel,
      confirmText: S.of(context).confirm,
    );
    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          startTime = pickedTime;
        } else {
          endTime = pickedTime;
        }
      });
    }
  }

  Future<void> _makeBooking() async {
    DateTime start = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, startTime.hour, startTime.minute);
    DateTime end = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, endTime.hour, endTime.minute);
    DateTime now = DateTime.now();

    if (_isBookingTimeInvalid(start, end, now)) return;

    if (_isBookingConflict(start, end)) return;

    if (_isBelowMinimumHours(start, end)) return;

    _processBooking(start, end);
  }

  bool _isBookingTimeInvalid(DateTime start, DateTime end, DateTime now) {
    if (start.isBefore(now)) {
      errorToast(msg: S.of(context).bookingTimeInPast);
      return true;
    }

    if (end.isBefore(start) || end.isAtSameMomentAs(start)) {
      errorToast(msg: S.of(context).endTimeBeforeStartTime);
      return true;
    }

    if (start.isBefore(now.add(const Duration(hours: 2)))) {
      errorToast(msg: S.of(context).startTimeTooSoon);
      return true;
    }

    return false;
  }

  bool _isBookingConflict(DateTime start, DateTime end) {
    for (Booking booking in bookings) {
      if ((start.isBefore(booking.endTime) && end.isAfter(booking.startTime)) ||
          (start.isAtSameMomentAs(booking.startTime) &&
              end.isAfter(booking.startTime)) ||
          (end.isAtSameMomentAs(booking.endTime) &&
              start.isBefore(booking.endTime))) {
        errorToast(msg: S.of(context).bookingConflict);
        return true;
      }
    }

    PlaceBloc.get()
        .allPlaces
        .firstWhere(
          (element) => element.id == widget.placeId,
        )
        .isBookingAllowed(start, end);
    return false;
  }

  bool _isBelowMinimumHours(DateTime start, DateTime end) {
    double reservationHours = (end.difference(start).inMinutes / 60).abs();
    double placeMinHours = PlaceBloc.get()
            .allPlaces
            .firstWhere((e) => e.id == widget.placeId)
            .minimumHours ??
        0;
    if (reservationHours < placeMinHours) {
      errorToast(
          msg:
              "${S.of(context).minimumBooking} ${placeMinHours} ${S.of(context).hours}");
      return true;
    }

    return false;
  }

  void _processBooking(DateTime start, DateTime end) {
    setState(() {
      double reservationPrice = PlaceBloc.get()
              .allPlaces
              .firstWhere((e) => e.id == widget.placeId)
              .price *
          (end.difference(start).inMinutes / 60);
      GamesBloc.get().booking = Booking(
          startTime: start, endTime: end, reservationPrice: reservationPrice);
      defaultToast(msg: S.of(context).saved);
      context.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        "bookings: ${bookings.map((e) => "start: ${e.startTime}, end: ${e.endTime}").toString()}");
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildAppBar(),
                  _buildBookingContent(),
                ],
              ),
            ),
          ),
          _buildSaveButton(),
          SizedBox(
            height: 2.h,
          )
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      actions: [SizedBox(height: 5.h)],
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
    );
  }

  Widget _buildBookingContent() {
    return BlocListener<PlaceBloc, PlaceState>(
      bloc: PlaceBloc.get(),
      listener: (context, state) {
        if (state is GetPlaceBookingsSuccess) {
          setState(() {
            debugPrint(state.bookings
                .map((e) => "start: ${e.startTime}, end: ${e.endTime}")
                .toString());
            bookings = state.bookings;
          });
        }
        if (state is PlaceError) {
          errorToast(
              msg: ExceptionManager(state.exception).translatedMessage());
        }
        if (state is SendBookingRequestSuccess) {
          defaultToast(msg: S.of(context).bookingSuccess);
          context.pop();
        }
      },
      child: BlocBuilder<PlaceBloc, PlaceState>(
        bloc: PlaceBloc.get(),
        builder: (context, state) {
          return state is GetPlaceBookingsLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      _buildCalendar(),
                      _buildTimePickers(),
                      SizedBox(height: 2.h),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget _buildCalendar() {
    return SizedBox(
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
    );
  }

  Widget _buildTimePickers() {
    return SizedBox(
      height: 50.h,
      width: 90.w,
      child: Row(
        children: [
          _buildTimePicker(
              isStartTime: true, title: S.of(context).from, time: startTime),
          const Spacer(),
          _buildTimePicker(
              isStartTime: false, title: S.of(context).to, time: endTime),
        ],
      ),
    );
  }

  Widget _buildTimePicker(
      {required bool isStartTime,
      required String title,
      required TimeOfDay time}) {
    return SizedBox(
      width: 43.w,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SubTitle(title),
              FittedBox(
                child: TimePickerDialog(
                  initialTime: time,
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: InkWell(onTap: () => _selectTime(isStartTime: isStartTime)),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return BlocBuilder<PlaceBloc, PlaceState>(
      bloc: PlaceBloc.get(),
      builder: (context, state) {
        return state is GetPlaceBookingsLoading
            ? const SizedBox()
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: DefaultButton(
                  isLoading: state is SendBookingRequestLoading,
                  text: S.of(context).save,
                  onPressed: _makeBooking,
                ),
              );
      },
    );
  }
}
