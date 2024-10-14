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

class CreateGameLoading extends GamesLoading {
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

class CreateGameError extends GamesError {
  CreateGameError(super.exception);
}

class CreateGameSuccess extends GamesState {
  final int gameId;

  const CreateGameSuccess(this.gameId);

  @override
  List<Object> get props => [gameId];
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

class GetGameLoading extends GamesLoading {
  @override
  List<Object> get props => [];
}

class GetGameError extends GamesError {
  GetGameError(super.exception);

  @override
  List<Object> get props => [exception];
}

class GetGameSuccess extends GamesState {
  final Game game;

  const GetGameSuccess(this.game);

  @override
  List<Object> get props => [game];
}

class ChangGameAvailabilitySuccess extends GamesState {
  final bool isPublic;

  const ChangGameAvailabilitySuccess(this.isPublic);

  @override
  List<Object> get props => [isPublic];
}

class JoinGameSuccess extends GamesState {
  final int gameId;

  const JoinGameSuccess(this.gameId);

  @override
  List<Object> get props => [gameId];
}

class JoinGameError extends GamesError {
  JoinGameError(super.exception);
}

class JoinGameLoading extends GamesLoading {
  final int gameId;

  JoinGameLoading(this.gameId);

  @override
  List<Object> get props => [gameId];
}

class LeaveGameSuccess extends GamesState {
  final int gameId;

  const LeaveGameSuccess(this.gameId);

  @override
  List<Object> get props => [gameId];
}

class LeaveGameError extends GamesError {
  LeaveGameError(super.exception);
}

class LeaveGameLoading extends GamesLoading {
  final int gameId;

  LeaveGameLoading(this.gameId);

  @override
  List<Object> get props => [gameId];
}

class SelectGamesSportSuccess extends GamesState {
  final int sportId;

  const SelectGamesSportSuccess(this.sportId);

  @override
  List<Object> get props => [sportId];
}

class SelectGamesSportLoading extends GamesState {
  final int sportId;

  const SelectGamesSportLoading(this.sportId);

  @override
  List<Object> get props => [sportId];
}

class SelectPlaceSuccess extends GamesState {
  final int placeName;

  const SelectPlaceSuccess(this.placeName);

  @override
  List<Object> get props => [placeName];
}

class GetUpcomingGamesSuccess extends GamesState {
  final List<Game> games; // upcoming games list

  const GetUpcomingGamesSuccess(this.games);

  @override
  List<Object> get props => [games];
}

class GetUpcomingGamesError extends GamesError {
  GetUpcomingGamesError(super.exception);
}

class GetUpcomingGamesLoading extends GamesLoading {
  @override
  List<Object> get props => [];
}
