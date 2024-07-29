// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:hawihub/src/modules/games/data/models/player.dart';

class Game extends Equatable {
  final int id;
  final String sportName;
  final double price;
  final DateTime date;
  final int placeId;
  final int maxPlayers;
  final int minPlayers;
  final double hours;
  final String sportImageUrl;
  final String placeAddress;
  final String placeName;
  final bool isPublic;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime deadline;
  List<GamePlayer> players;
  Host host;
  final int sportId;

  Game({
    required this.id,
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
    this.players = const [],
    required this.startTime,
    required this.endTime,
    required this.deadline,
    required this.sportId,
    required this.host,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['gameId'],
      sportName: "",
      price: json['gamePrice'].toDouble(),
      date: DateTime.parse(json['gameStartTime']),
      placeId: json['stadium']['stadiumId'],
      maxPlayers: json['maxPlayers'],
      minPlayers: json['minPlayers'],
      hours: ((DateTime.parse(json['gameEndTime'])
                          .difference(DateTime.parse(json['gameStartTime']))
                          .inMinutes
                          .abs() /
                      60) *
                  100)
              .round() /
          100,
      sportImageUrl: "",
      placeAddress: json['stadium']['address'],
      placeName: json['stadium']['name'],
      isPublic: json['isPublic'],
      startTime: DateTime.parse(json['gameStartTime']),
      endTime: DateTime.parse(json['gameEndTime']),
      deadline: DateTime.parse(json['deadline']),
      sportId: json['stadium']['categoryId'],
      players: _extractPlayers(json['gamePlayers']),
      host: Host.fromJson(json['host']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "stadiumId": placeId,
      "isPublic": isPublic,
      "gamePrice": price,
      "minPlayers": minPlayers,
      "maxPlayers": maxPlayers,
      "gameStartTime": startTime.toUtc().toIso8601String(),
      "gameEndTime": endTime.toUtc().toIso8601String(),
      "deadline": startTime
          .subtract(const Duration(hours: 1))
          .toUtc()
          .toIso8601String(),
    };
  }

  int getRemainingSlots() {
    return (maxPlayers - (players.length + 1));
  }

  String getConvertedDate() {
    return "${date.toUtc().day}/${date.toUtc().month}/${date.toUtc().year} - ${date.toUtc().hour}:${date.toUtc().minute}";
  }

  @override
  List<Object?> get props => [
        id,
      ];

  static List<GamePlayer> _extractPlayers(List playersJson) {
    List<Map<String, dynamic>> playersJsonInCast =
        List.castFrom<dynamic, Map<String, dynamic>>(playersJson);
    List<GamePlayer> players = [];
    for (Map<String, dynamic> playerJson in playersJsonInCast) {
      players.add(GamePlayer.fromJson(playerJson));
    }
    return players;
  }

  double getHostAge() {
    return host.getAge();
  }

  String getPriceAverage() {
    String max = (price / minPlayers).toStringAsFixed(2);
    String min = (price / maxPlayers).toStringAsFixed(2);
    return "~ $min : $max";
  }
}
