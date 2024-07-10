import 'dart:io';

import 'package:hawihub/src/modules/auth/data/models/user.dart';

class Player extends User {
  final int games;
  final int bookings;
  final String email;
  double myWallet;
  final DateTime birthDate;
  File? profilePictureFile;
  List<int> favoritePlaces;
  final List<int> stadiumReservation;
  final List<int> ownerReservatation;

  Player({
    required this.bookings,
    required this.games,
    required this.birthDate,
    required this.email,
    required this.stadiumReservation,
    required this.ownerReservatation,
    this.profilePictureFile,
    required this.myWallet,
    this.favoritePlaces = const [],
    required super.id,
    required super.userName,
    required super.profilePictureUrl,
    required super.feedbacks,
    super.proofOfIdentityUrl,
    required super.rate,
    required super.approvalStatus,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      profilePictureUrl: json['profilePictureUrl'],
      proofOfIdentityUrl: json['proofOfIdentityUrl'],
      id: json['id'],
      games: json['numberOfGames'],
      bookings: json['numberOfBookings'],
      userName: json['userName'],
      email: json['email'],
      birthDate: DateTime.parse(json['birthDate']),
      approvalStatus: json['approvalStatus'],
      myWallet: json['wallet'].toDouble(),
      rate: json["rate"].toDouble(),
      feedbacks: [],
      favoritePlaces: List.from(json['favoriteStadiums'] ?? []),
      stadiumReservation: List.from(json['stadiumReservatation'] ?? []),
      ownerReservatation: List.from(json['ownerReservatation'] ?? []),
    );
  }

  bool isVerified() {
    return approvalStatus == 1;
  }

  int getAge() {
    int age = (DateTime.now().difference(birthDate).inDays / 365).ceil();
    return age;
  }
}
