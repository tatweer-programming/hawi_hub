import 'dart:io';

import 'package:hawihub/src/modules/auth/data/models/user.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';

class Player extends User {
  final int games;
  final int bookings;
  final String email;
  final double myWallet;
  File? profilePictureFile;
  List<int> favoritePlaces;
  final List<int> stadiumReservation;
  final List<int> playerReservation;

  Player({
    required this.bookings,
    required this.games,
    required this.email,
    required this.stadiumReservation,
    required this.playerReservation,
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

    // List<int> favoritePlaces = [];
    // List favoritePlacesJson = json['favoriteStadiums'] ?? [];
    // if (favoritePlacesJson.isNotEmpty) {
    //   for (var element in favoritePlacesJson) {
    //     favoritePlaces.add(element['stadiumId']);
    //   }
    // }
    return Player(
      profilePictureUrl: json['profilePictureUrl'],
      proofOfIdentityUrl: json['proofOfIdentityUrl'],
      id: json['id'],
      games: json['numberOfGames'],
      bookings: json['numberOfBookings'],
      userName: json['userName'],
      email: json['email'],
      approvalStatus: json['approvalStatus'],
      myWallet: json['wallet'].toDouble(),
      rate: json["rate"].toDouble(),
      feedbacks: [],
      favoritePlaces: List.from(json['favoriteStadiums'] ?? []),
      stadiumReservation: List.from(json['stadiumReservatation'] ?? []),
      playerReservation: List.from(json['playerReservatation'] ?? []),
    );
  }
}
