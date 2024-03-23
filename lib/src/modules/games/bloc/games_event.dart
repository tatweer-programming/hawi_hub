part of 'games_bloc.dart';

abstract class GamesEvent extends Equatable {
  const GamesEvent();
}

class GetGamesEvent extends GamesEvent {
  @override
  List<Object> get props => [];
}

class JoinGameEvent extends GamesEvent {
  final int gameId;

  const JoinGameEvent({required this.gameId});

  @override
  List<Object> get props => [gameId];
}
