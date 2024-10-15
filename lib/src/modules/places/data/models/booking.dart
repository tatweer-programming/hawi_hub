class Booking {
  final int reservationId;
  final int placeId;

  final double reservationPrice;
  final DateTime reservationStartTime;
  final DateTime reservationEndTime;
  final int approvalStatus;
  final String placeName;
  final String placeAddress;
  final List<String> placeImages;

  Booking(
      {required this.reservationId,
      required this.placeId,
      required this.reservationPrice,
      required this.reservationStartTime,
      required this.reservationEndTime,
      required this.approvalStatus,
      required this.placeName,
      required this.placeAddress,
      required this.placeImages});

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
        reservationId: json['reservationId'] as int,
        placeId: json['stadium']['stadiumId'] as int,
        reservationPrice: (json['reservationPrice']).toDouble(),
        reservationStartTime: DateTime.parse(json['reservationStartTime']),
        reservationEndTime: DateTime.parse(json['reservationEndTime']),
        approvalStatus: json['approvalStatus'] as int,
        placeName: json["stadium"]["name"],
        placeAddress: json["stadium"]["address"],
        placeImages: _getImages(json["stadium"]["stadiumImages"]));
  }

  Map<String, dynamic> toJson() {
    return {
      'reservationId': reservationId,
      'placeId': placeId,
      'reservationPrice': reservationPrice,
      'reservationStartTime': reservationStartTime.toIso8601String(),
      'reservationEndTime': reservationEndTime.toIso8601String(),
      'approvalStatus': approvalStatus,
    };
  }

  static List<String> _getImages(List imagesJson) {
    return imagesJson.map((e) => e["stadiumImageUrl"].toString()).toList();
  }

  String getDate() {
    return reservationStartTime.day.toString() +
        "/" +
        reservationStartTime.month.toString() +
        "/" +
        reservationStartTime.year.toString();
  }

  String getTime() {
    return reservationStartTime.hour.toString() +
        ":" +
        reservationStartTime.minute.toString() +
        " - " +
        reservationEndTime.hour.toString() +
        ":" +
        reservationEndTime.minute.toString();
  }
}
