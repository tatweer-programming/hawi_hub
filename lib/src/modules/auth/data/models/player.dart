import 'dart:io';

import 'package:hawihub/src/modules/places/data/models/feedback.dart';

class Player {
  final int id;
  final String userName;
  final double? rate;
  final int games;
  final int bookings;
  final String email;
  final String profilePictureUrl;
  final double myWallet;
  final List<FeedBack> feedbacks;
  File? profilePictureFile;

  Player({
    required this.id,
    required this.userName,
    required this.bookings,
    required this.games,
    required this.email,
    required this.profilePictureUrl,
    this.profilePictureFile,
    required this.myWallet,
    required this.feedbacks,
    required this.rate,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      profilePictureUrl: json['image'],
      id: json['id'],
      // games: json['games'],
      games: 50,
      // bookings: json['bookings'],
      bookings: 20,
      userName: json['user_name'],
      email: json['mail'],
      myWallet: json['money'].toDouble(),
      rate: json['rate'] != null ? json['rate'].toDouble() : 0.0,
      feedbacks: [],
    );
  }
}
