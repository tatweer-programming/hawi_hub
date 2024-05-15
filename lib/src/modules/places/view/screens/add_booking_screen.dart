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
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:hawihub/src/modules/places/bloc/place__bloc.dart';

import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

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
  PlaceBloc bloc = PlaceBloc.get();
  String _formatTimeOfDay(TimeOfDay time) {
    return DateFormat.Hm().format(DateTime(time.hour, time.minute));
  }

  void _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        print(selectedDate);
      });
    }
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
    print(selectedDate);
    if (selectedDate == null || startTime == null || endTime == null) {
      // Show error message
      errorToast(msg: S.of(context).allFieldsIsRequired);
      return;
    }

    // Validate that end time is after start time
    if (endTime.hour < startTime.hour ||
        (endTime.hour == startTime.hour && endTime.minute <= startTime.minute)) {
      errorToast(msg: S.of(context).endTimeMustBeAfterStartTime);
      return;
    }

    final bookingStartTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      startTime.hour,
      startTime.minute,
    );
    final bookingEndTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      endTime.hour,
      endTime.minute,
    );
    // PlaceBloc.get().currentPlace!.isBookingAllowed(bookingStartTime, bookingEndTime)
    //     ? await PlaceBloc.get().createBooking(bookingStartTime, bookingEndTime, widget.placeId)
    //     : errorToast(msg: S.of(context).bookingNotAllowed);
  }

  @override
  void initState() {
    bloc.add(GetPlaceBookingsEvent(widget.placeId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                      ),
                      child: SizedBox(
                        height: 7.h,
                        child: Text(
                          S.of(context).bookNow,
                          style: TextStyleManager.getAppBarTextStyle(),
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<PlaceBloc, PlaceState>(
                    bloc: bloc,
                    builder: (context, state) {
                      return BlocListener<PlaceBloc, PlaceState>(
                        bloc: PlaceBloc.get(),
                        listener: (context, state) {
                          if (state is PlaceError) {
                            errorToast(msg: ExceptionManager(state.exception).translatedMessage());
                          }
                          if (state is SendBookingRequestSuccess) {
                            defaultToast(msg: S.of(context).requestSent);
                            context.pop();
                          }
                        },
                        child: state is GetPlaceBookingsLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Column(children: [
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
                                                child: Builder(builder: (context) {
                                                  return CalendarDatePicker(
                                                    initialCalendarMode: DatePickerMode.day,
                                                    currentDate: selectedDate,
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime.now()
                                                        .add(const Duration(days: 365)),
                                                    initialDate: selectedDate,
                                                    onDateChanged: (DateTime value) {
                                                      setState(() {
                                                        selectedDate = value;
                                                      });
                                                    },
                                                    // currentDate: selectedDate,
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Positioned.fill(child: InkWell(onTap: _selectDate))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50.h,
                                    width: 90.w,
                                    child: Row(children: [
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
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                ]),
                              ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: DefaultButton(
                text: S.of(context).save,
                onPressed: () {
                  _makeBooking();
                }),
          )
        ],
      ),
    );
  }
}
