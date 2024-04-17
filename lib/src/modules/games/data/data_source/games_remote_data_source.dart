import 'package:dartz/dartz.dart';
import 'package:hawihub/src/modules/games/data/models/game.dart';

import '../models/player.dart';

class GamesRemoteDataSource {
  List<Game> games = [
    Game(
      sportName: 'Football',
      date: DateTime.now().add(Duration(
        days: 2,
      )),
      placeId: 1,
      maxPlayers: 10,
      minPlayers: 2,
      hours: 2,
      sportImageUrl:
          'https://img.freepik.com/free-photo/soccer-game-concept_23-2151043760.jpg?size=626&ext=jpg&ga=GA1.1.1421918932.1712370188&semt=ais',
      placeAddress: 'Cairo Stadium, 6th of October Cairo, Egypt',
      placeName: 'Cairo Stadium',
      isPublic: true,
      players: const [
        GamePlayer(
            id: 1,
            name: "player 10",
            imageUrl:
                'https://img.freepik.com/free-psd/3d-illustration-person-with-glasses_23-2149436190.jpg?size=626&ext=jpg',
            isHost: true),
        GamePlayer(
            id: 2,
            name: "player 2",
            imageUrl:
                'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?size=626&ext=jpg'),
        GamePlayer(
            id: 3,
            name: "player 3",
            imageUrl:
                'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=626&ext=jpg'),
        GamePlayer(
            id: 4,
            name: "player 4",
            imageUrl:
                'https://img.freepik.com/free-psd/3d-illustration-person-with-glasses_23-2149436190.jpg?size=626&ext=jpg'),
      ],
      id: 1,
      price: 11,
    ),
    Game(
      sportName: 'Tennis',
      date: DateTime.now().add(Duration(
        days: 2,
      )),
      placeId: 1,
      maxPlayers: 4,
      minPlayers: 2,
      hours: 2,
      sportImageUrl:
          "https://img.freepik.com/free-photo/tennis-balls-black-racket_23-2148208239.jpg?size=626&ext=jpg&ga=GA1.1.1421918932.1712370188&semt=ais",
      placeAddress: 'Tennis Court, Cairo Stadium, 6th of October Cairo, Egypt',
      placeName: 'Tennis Court Cairo Stadium',
      isPublic: true,
      players: const [
        GamePlayer(
            id: 1,
            name: "player 1",
            imageUrl:
                'https://img.freepik.com/free-psd/3d-illustration-person-with-glasses_23-2149436190.jpg?size=626&ext=jpg',
            isHost: true),
        GamePlayer(
            id: 2,
            name: "player 2",
            imageUrl:
                'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?size=626&ext=jpg'),
        GamePlayer(
            id: 3,
            name: "player 3",
            imageUrl:
                'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=626&ext=jpg'),
        GamePlayer(
            id: 4,
            name: "player 4",
            imageUrl:
                'https://img.freepik.com/free-psd/3d-illustration-person-with-glasses_23-2149436190.jpg?size=626&ext=jpg'),
      ],
      id: 1,
      price: 6,
    ),
    Game(
      sportName: 'Baseball',
      date: DateTime.now().add(const Duration(
        days: 2,
      )),
      placeId: 1,
      maxPlayers: 10,
      minPlayers: 2,
      hours: 2,
      sportImageUrl:
          'https://images.pexels.com/photos/1661950/pexels-photo-1661950.jpeg?auto=compress&cs=tinysrgb&w=400',
      placeAddress: 'Cairo Stadium, Baseball Court, 6th of October Cairo, Egypt',
      placeName: 'Cairo Stadium Baseball Court',
      isPublic: true,
      players: const [
        GamePlayer(
            id: 1,
            name: "player 1",
            imageUrl:
                'https://img.freepik.com/free-psd/3d-illustration-person-with-glasses_23-2149436190.jpg?size=626&ext=jpg',
            isHost: true),
        GamePlayer(
            id: 2,
            name: "player 2",
            imageUrl:
                'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?size=626&ext=jpg'),
        GamePlayer(
            id: 3,
            name: "player 3",
            imageUrl:
                'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=626&ext=jpg'),
        GamePlayer(
            id: 4,
            name: "player 4",
            imageUrl:
                'https://img.freepik.com/free-psd/3d-illustration-person-with-glasses_23-2149436190.jpg?size=626&ext=jpg'),
      ],
      id: 1,
      price: 6,
    ),
    Game(
      sportName: 'Basketball',
      date: DateTime.now().add(Duration(
        days: 2,
      )),
      placeId: 1,
      maxPlayers: 10,
      minPlayers: 2,
      hours: 2,
      sportImageUrl:
          'https://img.freepik.com/free-photo/basketball-player-throwing-ball-into-net_23-2148393872.jpg?size=626&ext=jpg',
      placeAddress: 'Cairo Stadium, Basketball Court, 6th of October Cairo, Egypt',
      placeName: 'Cairo Stadium Basketball Court',
      isPublic: true,
      players: const [
        GamePlayer(
            id: 1,
            name: "player 1",
            imageUrl:
                'https://img.freepik.com/free-psd/3d-illustration-person-with-glasses_23-2149436190.jpg?size=626&ext=jpg',
            isHost: true),
        GamePlayer(
            id: 2,
            name: "player 2",
            imageUrl:
                'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?size=626&ext=jpg'),
        GamePlayer(
            id: 3,
            name: "player 3",
            imageUrl:
                'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=626&ext=jpg'),
        GamePlayer(
            id: 4,
            name: "player 4",
            imageUrl:
                'https://img.freepik.com/free-psd/3d-illustration-person-with-glasses_23-2149436190.jpg?size=626&ext=jpg'),
      ],
      id: 1,
      price: 8,
    ),
    Game(
      sportName: 'Football',
      date: DateTime.now().add(Duration(
        days: 2,
      )),
      placeId: 1,
      maxPlayers: 10,
      minPlayers: 2,
      hours: 2,
      sportImageUrl:
          'https://img.freepik.com/free-photo/soccer-game-concept_23-2151043760.jpg?size=626&ext=jpg&ga=GA1.1.1421918932.1712370188&semt=ais',
      placeAddress: 'Cairo Stadium, 6th of October Cairo, Egypt',
      placeName: 'Cairo Stadium',
      isPublic: true,
      players: const [
        GamePlayer(
            id: 1,
            name: "player 1",
            imageUrl:
                'https://img.freepik.com/free-psd/3d-illustration-person-with-glasses_23-2149436190.jpg?size=626&ext=jpg',
            isHost: true),
        GamePlayer(
            id: 2,
            name: "player 2",
            imageUrl:
                'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?size=626&ext=jpg'),
        GamePlayer(
            id: 3,
            name: "player 3",
            imageUrl:
                'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=626&ext=jpg'),
        GamePlayer(
            id: 4,
            name: "player 4",
            imageUrl:
                'https://img.freepik.com/free-psd/3d-illustration-person-with-glasses_23-2149436190.jpg?size=626&ext=jpg'),
      ],
      id: 1,
      price: 11,
    ),
  ];
  Future<Either<Exception, List<Game>>> getGames() async {
    await startTimer(2.1);
    return Right(games);
  }

  Future<Either<Exception, String>> createGame({required Game game}) {
    throw UnimplementedError();
  }
}

Future<bool> startTimer(double seconds) async {
  int secondsInt = seconds.truncate();
  int milliseconds = ((seconds - secondsInt) * 1000).toInt();

  await Future.delayed(Duration(seconds: secondsInt, milliseconds: milliseconds));
  return true;
}
