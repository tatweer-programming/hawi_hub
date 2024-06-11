import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hawihub/src/core/error/remote_error.dart';
import 'package:hawihub/src/modules/games/data/models/game.dart';
import 'package:hawihub/src/modules/games/view/widgets/components.dart';

import '../data/data_source/games_remote_data_source.dart';

part 'games_event.dart';

part 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  List<Game> games = [];
  List<Game> filteredGames = [];
  Game? currentGame;
  bool isPublic = false;

  GamesRemoteDataSource remoteDataSource = GamesRemoteDataSource();
  GamesBloc() : super(GamesInitial()) {
    on<GamesEvent>((event, emit) async {
      if (event is GetGamesEvent) {
        if (games.isEmpty) {
          emit(GetGamesLoading());
          var result = await remoteDataSource.getGames(cityId: event.cityId);
          result.fold((l) => null, (r) {
            games = r;
            emit(GetGamesSuccess(r));
          });
        }
      }
      if (event is ChangeGameAccessEvent) {
        isPublic = event.isPublic;
        emit(ChangGameAvailabilitySuccess(isPublic));
      }
    });
  }

  static GamesBloc? bloc;
  static GamesBloc get() {
    bloc ??= GamesBloc();
    return bloc!;
  }
}
