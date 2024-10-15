import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/core/utils/images_manager.dart';
import 'package:hawihub/src/modules/places/data/models/place.dart';

class GamePlayer {
  final String name;
  final int id;
  final String imageUrl;
  final bool isHost;

  const GamePlayer(
      {required this.name,
      required this.id,
      required this.imageUrl,
      this.isHost = false});

  factory GamePlayer.fromJson(Map<String, dynamic> json) {
    return GamePlayer(
      isHost: false,
      name: json['userName'],
      id: json['playerId'],
      imageUrl: json['profilePictureUrl'] ?? ImagesManager.defaultProfile,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_host': isHost,
      'name': name,
      'id': id,
      'image_url': imageUrl,
    };
  }

  factory GamePlayer.currentPlayer() {
    return GamePlayer(
      isHost: false,
      name: ConstantsManager.appUser!.userName,
      id: ConstantsManager.appUser!.id,
      imageUrl: ConstantsManager.appUser!.profilePictureUrl ??
          ImagesManager.defaultProfile,
    );
  }
}

class Host extends GamePlayer {
  final String birthDate;
  final Gender gender;

  Host({
    required super.name,
    required super.id,
    required super.imageUrl,
    super.isHost = true,
    required this.birthDate,
    required this.gender,
  });

  @override
  factory Host.fromJson(Map<String, dynamic> json) {
    return Host(
      isHost: true,
      gender: getGender(json['gender']),
      name: json['userName'],
      id: json['playerId'],
      imageUrl: json['profilePictureUrl'] ?? ImagesManager.defaultProfile,
      birthDate: json['birthDate'],
    );
  }

  double getAge() {
    return DateTime.now().difference(DateTime.parse(birthDate)).inDays / 365;
  }

  static Gender getGender(int genderId) {
    switch (genderId) {
      case 0:
        return Gender.male;
      case 1:
        return Gender.female;
    }
    return Gender.both;
  }
}
