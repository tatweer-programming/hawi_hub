import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/core/utils/images_manager.dart';

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
  Host(
      {required super.name,
      required super.id,
      required super.imageUrl,
      super.isHost = true});

  @override
  factory Host.fromJson(Map<String, dynamic> json) {
    return Host(
      name: json['userName'],
      id: json['playerId'],
      imageUrl: json['profilePictureUrl'] ?? ImagesManager.defaultProfile,
    );
  }
}
