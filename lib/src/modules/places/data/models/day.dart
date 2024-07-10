import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Day extends Equatable {
  final int dayOfWeek;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const Day(
      {required this.dayOfWeek,
      required this.startTime,
      required this.endTime});

  bool isWeekend() {
    return startTime.hour == 0 &&
        startTime.minute == 0 &&
        endTime.hour == 0 &&
        endTime.minute == 0;
  }

  bool isAllDay() {
    return startTime.hour == 0 &&
        startTime.minute == 0 &&
        endTime.hour == 23 &&
        endTime.minute == 59;
  }

  // isBookingAvailable(int startTime, int endTime) {
  //   if (!isWeekend()) {
  //     return startTime >= this.startTime! && endTime <= this.endTime!;
  //   }
  // }

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
        dayOfWeek: json['dayOfWeek'],
        startTime: json['startTime'].toString().parseToTimeOfDay(),
        endTime: json['endTime'].toString().parseToTimeOfDay());
  }

  @override
  List<Object?> get props => [];

  bool isBookingStartAllowed(DateTime bookingStart) {
    if (isAllDay()) {
      return true;
    }
    if (isWeekend()) {
      return false;
    }
    TimeOfDay startBooking = TimeOfDay.fromDateTime(bookingStart);
    return startBooking.hour >= startTime.hour &&
        (startBooking.hour != startTime.hour ||
            startBooking.minute >= startTime.minute);
  }

  bool isBookingEndAllowed(DateTime bookingEnd) {
    if (isAllDay()) {
      return true;
    }
    if (isWeekend()) {
      return false;
    }
    TimeOfDay endBooking = TimeOfDay.fromDateTime(bookingEnd);
    return endBooking.hour <= endTime.hour &&
        (endBooking.hour != endTime.hour ||
            endBooking.minute <= endTime.minute);
  }
}

extension TimeOfDayExtension on String {
  TimeOfDay? tryParseToTimeOfDay() {
    final List<String> parts = split(":");

    final int? hour = int.tryParse(parts[0]);
    final int? minute = int.tryParse(parts[1]);

    if (hour == null ||
        minute == null ||
        hour < 0 ||
        hour >= 23 ||
        minute < 0 ||
        minute >= 59) {
      return null;
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  TimeOfDay parseToTimeOfDay() {
    final List<String> parts = split(":");
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
