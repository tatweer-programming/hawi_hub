// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:hawihub/src/modules/games/data/models/player.dart';

import '../../../auth/data/models/player.dart';

class Game extends Equatable {
  final int id;
  final String sportName;
  final double price;
  final DateTime date;
  final int placeId;
  final int maxPlayers;
  final int minPlayers;
  final int hours;
  final String sportImageUrl;
  final String placeAddress;
  final String placeName;
  final bool isPublic;
  List<GamePlayer> players;

  Game(
      {required this.id,
      required this.sportName,
      required this.price,
      required this.date,
      required this.placeId,
      required this.maxPlayers,
      required this.minPlayers,
      required this.hours,
      required this.sportImageUrl,
      required this.placeAddress,
      required this.placeName,
      required this.isPublic,
      this.players = const []});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      sportName: json['sport_name'],
      price: json['price'],
      date: DateTime.parse(json['date']),
      placeId: json['place_id'],
      maxPlayers: json['max_players'],
      minPlayers: json['min_players'],
      hours: json['hours'],
      sportImageUrl: json['sport_image_url'],
      placeAddress: json['place_address'],
      placeName: json['place_name'],
      isPublic: json['is_public'],
      players: _extractPlayers(json['players'] as List<Map<String, dynamic>>),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'sport_name': sportName,
      'date': date.toIso8601String(),
      'place_id': placeId,
      'max_players': maxPlayers,
      'min_players': minPlayers,
      'hours': hours,
      'sport_image_url': sportImageUrl,
      'place_address': placeAddress,
      'place_name': placeName,
      'is_public': isPublic,
      'players': players.map((e) => e.toJson()).toList(),
    };
  }

  int getRemainingSlots() {
    return (maxPlayers - players.length);
  }

  String getConvertedDate() {
    return "${date.toUtc().day}/${date.toUtc().month}/${date.toUtc().year} - ${date.toUtc().hour}:${date.toUtc().minute}";
  }

  @override
  List<Object?> get props => [
        id,
      ];

  static List<GamePlayer> _extractPlayers(List<Map<String, dynamic>> playersJson) {
    List<GamePlayer> players = [];
    for (Map<String, dynamic> playerJson in playersJson) {
      players.add(GamePlayer.fromJson(playerJson));
    }
    return players;
  }
}
