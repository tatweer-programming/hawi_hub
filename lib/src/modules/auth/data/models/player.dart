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
      profilePictureUrl: json['profile_image'],
      id: json['id'],
      games: json['num_games'],
      bookings: json['num_bookings'],
      userName: json['user_name'],
      email: json['email'],
      myWallet: json['my_wallet'].toDouble(),
      rate: json['rate'] != null ? json['rate'].toDouble() : 0.0,
      feedbacks: [],
    );
  }
}
