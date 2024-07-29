import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
import 'package:hawihub/src/modules/games/data/models/game.dart';
import 'package:hawihub/src/modules/games/data/models/game_creation_form.dart';
import 'package:hawihub/src/modules/games/data/models/player.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/places/bloc/place_bloc.dart';
import 'package:hawihub/src/modules/places/data/models/booking.dart';
import 'package:hawihub/src/modules/places/data/models/place.dart';

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
        if (games.isEmpty || event.refresh) {
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
        double balance = _getBalance(event.gameId);
        emit(JoinGameLoading(
          event.gameId,
        ));
        var result = await remoteDataSource.joinGame(
            game: games.firstWhere((e) => e.id == event.gameId),
            balance: balance);
        result.fold((l) {
          emit(JoinGameError(l));
        }, (r) async {
          games
              .firstWhere((e) => e.id == event.gameId)
              .players
              .add(GamePlayer.currentPlayer());
          emit(JoinGameSuccess(event.gameId));
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
      } else if (event is SelectPlaceEvent) {
        selectedStadiumId = PlaceBloc.get()
            .viewedPlaces
            .firstWhere((e) => e.id == event.placeId)
            .id;
        emit(SelectPlaceSuccess(PlaceBloc.get()
            .viewedPlaces
            .firstWhere((e) => e.id == event.placeId)
            .id));
      }
    });
  }

  static GamesBloc? bloc;

  static GamesBloc get() {
    bloc ??= GamesBloc();
    return bloc!;
  }

  double _getBalance(int gameId) {
    Game game = games.firstWhere((e) => e.id == gameId);
    return game.price / game.minPlayers;
  }

  String getSelectedPlaceSportName() {
    Place selectedPlace = PlaceBloc.get()
        .allPlaces
        .firstWhere((element) => element.id == selectedStadiumId);
    int sportId = selectedPlace.sport;
    return MainCubit.get()
        .sportsList
        .firstWhere((element) => element.id == sportId)
        .name;
  }
}
