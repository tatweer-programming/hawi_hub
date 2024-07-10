class Booking {
  final DateTime startTime;
  final DateTime endTime;
  final double? reservationPrice;

  const Booking(
      {required this.startTime,
      required this.endTime,
      this.reservationPrice = 0.0});

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
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
}
