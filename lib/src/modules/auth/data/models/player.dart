import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hawihub/src/modules/auth/data/models/user.dart';

class Player {
  String? id;
  String? password;
  final String userName;
  final String email;
  String? profilePictureUrl;
  File? profilePictureFile;
  final double myWallet;

  Player({
    this.id,
    this.password,
    required this.userName,
    required this.email,
    required this.profilePictureUrl,
    this.profilePictureFile,
    required this.myWallet,
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      "image": profilePictureUrl,
      "user_name": userName,
      "mail": email,
      "pass": password,
      //'myWallet': myWallet,
    };
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      myWallet: json['myWallet'],
      userName: json['user_name'],
      email: json['mail'],
      profilePictureUrl: json['image'],
    );
  }
}
