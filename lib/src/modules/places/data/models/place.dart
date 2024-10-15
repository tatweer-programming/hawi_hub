import 'package:equatable/equatable.dart';
import 'package:hawihub/src/core/utils/images_manager.dart';
import 'package:hawihub/src/modules/places/data/models/day.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';
import 'package:hawihub/src/modules/places/data/models/place_location.dart';

enum Gender {
  male(1),
  female(2),
  both(3);

  final int value;

  const Gender(this.value);
}

// TODO : add this To Ui
class Place extends Equatable {
  int id;
  String name;
  String address;
  List<Day>? workingHours; // int day, String startTime, String endTime
  PlaceLocation? location; // String longitude, String latitude
  String? description;
  int sport;
  double price;
  int ownerId;
  double? minimumHours;
  List<String> images;
  int totalGames;
  int totalRatings;
  double? rating;
  List<AppFeedBack>? feedbacks; // []
  String ownerName;
  String ownerImage;
  int citId;
  int approvalStatus;
  Gender availableGender;
  int deposit;

  bool isShared;

  Place(
      {required this.id,
      required this.name,
      required this.address,
      this.workingHours,
      this.location,
      this.description,
      required this.sport,
      required this.price,
      required this.ownerId,
      this.minimumHours,
      required this.images,
      required this.totalGames,
      required this.totalRatings,
      this.rating,
      this.feedbacks,
      required this.citId,
      this.approvalStatus = 0,
      required this.ownerName,
      required this.ownerImage,
      this.availableGender = Gender.both,
      this.deposit = 0,
      required this.isShared});

  factory Place.fromJson(Map<String, dynamic> json) {
    List openTimesList = json["openTimes"];
    print(openTimesList);
    List<Day> days = [];
    for (var element in openTimesList) {
      print(Day.fromJson(element));
      days.add(Day.fromJson(element));
    }
    return Place(
        citId: json['cityId'],
        id: json['stadiumId'],
        name: json['name'],
        description: json['description'],
        address: json['address'],
        images:
            List<String>.from(json['images'].map((x) => x['stadiumImageUrl'])),
        approvalStatus: json['approvalStatus'],
        ownerId: json['owner']['ownerId'],
        minimumHours: json['minHoursReservation'],
        price: json['pricePerHour'],
        totalGames: json['totalGames'] ?? 0,
        totalRatings: json['totalRatings'] ?? 0,
        rating: json['rate'].toDouble(),
        feedbacks: const [],
        workingHours:
            List<Day>.from(json["openTimes"].map((x) => Day.fromJson(x))),
        location: PlaceLocation.fromString(json['location'] ?? ""),
        sport: json['categoryId'] ?? 0,
        ownerName: json['owner']['userName'] ?? "",
        ownerImage: json['owner']['ownerImage'] ?? ImagesManager.defaultProfile,
        availableGender: _getGender(json["availableGender"] ?? 2),
        deposit: json["deposit"] ?? 0,
        isShared: json["isShared"] ?? false);
  }

  static Gender _getGender(int value) {
    switch (value) {
      case 0:
        return Gender.male;
      case 1:
        return Gender.female;
      default:
        return Gender.both;
    }
  }

  static List<Day> getWeekDays(List<Map<String, dynamic>> weekDays) {
    List<Day> days = [];
    for (var element in weekDays) {
      days.add(Day.fromJson(element));
    }
    return days;
  }

  bool isBookingAllowed(DateTime startTime, DateTime endTime) {
    // get day index
    // check if time is in working hours
    int dayIndex = getDayIndex(startTime);
    int dayEndIndex = getDayIndex(endTime);
    return workingHours![dayIndex].isBookingStartAllowed(
          startTime,
        ) &&
        workingHours![dayEndIndex].isBookingEndAllowed(endTime);
  }

  int getDayIndex(DateTime startTime) {
    switch (startTime.weekday) {
      case DateTime.sunday:
        return 0;
      case DateTime.monday:
        return 1;
      case DateTime.tuesday:
        return 2;
      case DateTime.wednesday:
        return 3;
      case DateTime.thursday:
        return 4;
      case DateTime.friday:
        return 5;
      default:
        return 6;
    }
  }

  @override
  List<Object?> get props => [];
}
