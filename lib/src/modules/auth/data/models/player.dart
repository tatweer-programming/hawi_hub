import 'dart:io';

import 'package:hawihub/src/modules/places/data/models/feedback.dart';

class Player {
  final int id;
  final int approvalStatus;
  final String userName;
  final double? rate;
  final int games;
  final int bookings;
  final String email;
  final String? profilePictureUrl;
  final double myWallet;
  final List<AppFeedBack> feedbacks;
  File? profilePictureFile;
  String? proofOfIdentityUrl;
  List<int> favoritePlaces;

  Player({
    required this.id,
    required this.userName,
    required this.bookings,
    required this.games,
    required this.email,
    required this.approvalStatus,
    required this.profilePictureUrl,
    this.profilePictureFile,
    this.proofOfIdentityUrl,
    required this.myWallet,
    required this.feedbacks,
    required this.rate,
    this.favoritePlaces = const [],
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    List<AppFeedBack> feedbacks = List.from(json['reviews'] ?? [])
        .map((feedback) => AppFeedBack.fromJson(feedback))
        .toList();
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
      rate: _calculateAverage(feedbacks),
      feedbacks: feedbacks,
      favoritePlaces: json['favoriteStadiums'] ?? [],
    );
  }

  static double _calculateAverage(List<AppFeedBack>? feedbacks) {
    List<double> numbers =
        List.from(feedbacks!.map((feedBack) => feedBack.rating));
    if (numbers.isEmpty) {
      return 0.0;
    }
    double sum = 0.0;
    for (double number in numbers) {
      sum += number;
    }
    return sum / numbers.length;
  }
}
