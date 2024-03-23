part of 'games_bloc.dart';

abstract class GamesState extends Equatable {
  const GamesState();
}

class GamesInitial extends GamesState {
  @override
  List<Object> get props => [];
}

/// all games loading states will extend this class
class GamesLoading extends GamesState {
  @override
  List<Object> get props => [];
}

class GetGamesLoading extends GamesState {
  @override
  List<Object> get props => [];
}

/// all games error states will extend this class
class GamesError extends GamesState {
  final Exception exception;

  GamesError(this.exception) {
    ExceptionManager(exception).translatedMessage();
  }

  @override
  List<Object> get props => [exception];
}

class GetGamesError extends GamesError {
  GetGamesError(super.exception);
}

class GetGamesSuccess extends GamesState {
  final List<Game> games;

  const GetGamesSuccess(this.games);

  @override
  List<Object> get props => [games];
}
