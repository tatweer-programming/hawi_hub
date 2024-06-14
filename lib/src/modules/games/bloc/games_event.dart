part of 'games_bloc.dart';

abstract class GamesEvent extends Equatable {
  const GamesEvent();
}

class GetGamesEvent extends GamesEvent {
  final int cityId;
  const GetGamesEvent(this.cityId);
  @override
  List<Object> get props => [];
}

class GetGameEvent extends GamesEvent {
  final int gameId;
  const GetGameEvent(this.gameId);

  @override
  List<Object> get props => [gameId];
}

class JoinGameEvent extends GamesEvent {
  final int gameId;

  const JoinGameEvent({required this.gameId});

  @override
  List<Object> get props => [gameId];
}

class ChangeGameAccessEvent extends GamesEvent {
  final bool isPublic;
  const ChangeGameAccessEvent({required this.isPublic});

  @override
  List<Object> get props => [isPublic];
}

class CreateGameEvent extends GamesEvent {
  final int minPlayers;
  final int maxPlayers;
  const CreateGameEvent({required this.minPlayers, required this.maxPlayers});
  @override
  List<Object> get props => [minPlayers, maxPlayers];
}

