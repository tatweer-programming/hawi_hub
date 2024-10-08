class PlaceBooking {
  final DateTime startTime;
  final DateTime endTime;
  final double? reservationPrice;

  const PlaceBooking(
      {required this.startTime,
      required this.endTime,
      this.reservationPrice = 0.0});

  factory PlaceBooking.fromJson(Map<String, dynamic> json) {
    return PlaceBooking(
        startTime: DateTime.parse(json['reservationStartTime']),
        endTime: DateTime.parse(json['reservationEndTime']));
  }

  Map<String, dynamic> toJson(
          {required int stadiumId, required double reservationPrice}) =>
      {
        "stadiumId": stadiumId,
        "reservationPrice": reservationPrice,
        "reservationStartTime": startTime.toIso8601String(),
        "reservationEndTime": endTime.toIso8601String()
      };

  bool isConflicting(
      PlaceBooking newBooking,
      ) {
    return (newBooking.startTime.isBefore(endTime) ||
        newBooking.startTime.isAtSameMomentAs(endTime)) &&
        (newBooking.endTime.isAfter(startTime) ||
            newBooking.endTime.isAtSameMomentAs(startTime));
  }

}
