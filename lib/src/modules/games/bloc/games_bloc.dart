import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hawihub/src/core/error/remote_error.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/modules/games/data/models/game.dart';
import 'package:hawihub/src/modules/games/data/models/game_creation_form.dart';
import 'package:hawihub/src/modules/games/data/models/player.dart';
import 'package:hawihub/src/modules/games/view/widgets/components.dart';
import 'package:hawihub/src/modules/main/data/models/app_notification.dart';
import 'package:hawihub/src/modules/main/data/services/notification_services.dart';
import 'package:hawihub/src/modules/places/bloc/place__bloc.dart';
import 'package:hawihub/src/modules/places/data/models/booking.dart';

import '../data/data_source/games_remote_data_source.dart';

part 'games_event.dart';

part 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  List<Game> games = [];
  List<Game> filteredGames = [];
  Game? currentGame;
  bool isPublic = false;
  int? selectedStadiumId;
  Booking? booking;
  GamesRemoteDataSource remoteDataSource = GamesRemoteDataSource();

  GamesBloc() : super(GamesInitial()) {
    on<GamesEvent>((event, emit) async {
      if (event is GetGamesEvent) {
        if (games.isEmpty) {
          emit(GetGamesLoading());
          var result = await remoteDataSource.getGames(cityId: event.cityId);
          result.fold((l) {
            emit(GetGamesError(l));
          }, (r) {
            games = r;
            filteredGames = r;
            emit(GetGamesSuccess(r));
          });
        }
      } else if (event is GetGameEvent) {
        emit(GetGameLoading());
        var result = await remoteDataSource.getGame(gameId: event.gameId);
        result.fold((l) {
          emit(GetGameError(l));
        }, (r) {
          currentGame = r;
          emit(GetGameSuccess(r));
        });
      } else if (event is JoinGameEvent) {
        emit(JoinGameLoading());
        var result = await remoteDataSource.joinGame(gameId: event.gameId);
        result.fold((l) {
          emit(JoinGameError(l));
        }, (r) async {
          games
              .firstWhere((e) => e.id == event.gameId)
              .players
              .add(GamePlayer.currentPlayer());
          emit(const JoinGameSuccess());
          await NotificationServices().sendNotification(AppNotification(
              title: "${ConstantsManager.appUser?.userName} joined your game",
              body:
                  "${ConstantsManager.appUser?.userName} joined your game in ${games.firstWhere((element) => element.id == event.gameId).placeName}",
              id: 1,
              receiverId: games
                  .firstWhere((element) => element.id == event.gameId)
                  .host
                  .id));
        });
      }
      if (event is ChangeGameAccessEvent) {
        isPublic = event.isPublic;
        emit(ChangGameAvailabilitySuccess(isPublic));
      } else if (event is CreateGameEvent) {
        print(
            "price for stadium ${PlaceBloc.get().allPlaces.firstWhere((element) => element.id == selectedStadiumId).price}");

        double gamePrice = (PlaceBloc.get()
                .allPlaces
                .firstWhere((element) => element.id == selectedStadiumId)
                .price) *
            (booking!.endTime.difference(booking!.startTime).inMinutes / 60)
                .abs();
        print("price $gamePrice");
        GameCreationForm gameCreationForm = GameCreationForm(
          stadiumId: selectedStadiumId!,
          isPublic: isPublic,
          gamePrice: gamePrice,
          minPlayers: event.minPlayers,
          maxPlayers: event.maxPlayers,
          gameStartTime: booking!.startTime,
          gameEndTime: booking!.endTime,
        );
        emit(CreateGameLoading());
        var result = await remoteDataSource.createGame(game: gameCreationForm);
        result.fold((l) {
          emit(CreateGameError(l));
        }, (r) {
          emit(CreateGameSuccess(int.parse(r)));
        });
      } else if (event is SelectSportEvent) {
        if (event.sportId == -1) {
          filteredGames = games;
          emit(const SelectSportSuccess(-1));
          print("games $games");
        } else {
          filteredGames = games
              .where((element) => element.sportId == event.sportId)
              .toList();
          print("games $games");
          emit(SelectSportSuccess(event.sportId));
        }
      }
    });
  }

  static GamesBloc? bloc;

  static GamesBloc get() {
    bloc ??= GamesBloc();
    return bloc!;
  }
}
