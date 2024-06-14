class GameCreationForm {
 final int stadiumId;
 final bool isPublic;
 final double gamePrice;
 final int minPlayers;
 final int maxPlayers;
 final DateTime gameStartTime;
 final DateTime gameEndTime;
 late String deadline;
 GameCreationForm({
  required this.stadiumId,
  required this.isPublic,
  required this.gamePrice,
  required this.minPlayers,
  required this.maxPlayers,
  required this.gameStartTime,
  required this.gameEndTime,

  });
  Map <String, dynamic> toJson() => {
  "stadiumId": stadiumId,
  "isPublic": isPublic,
  "gamePrice": gamePrice,
  "minPlayers": minPlayers,
  "maxPlayers": maxPlayers,
  "gameStartTime": gameStartTime.toUtc().toIso8601String(),
  "gameEndTime": gameEndTime.toUtc().toIso8601String(),
  "deadline": gameStartTime.subtract(const Duration(hours: 1)).toUtc().toUtc().toIso8601String()
  };

}