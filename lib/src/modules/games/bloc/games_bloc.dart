import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hawihub/src/core/error/remote_error.dart';
import 'package:hawihub/src/modules/games/data/models/game.dart';

part 'games_event.dart';

part 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  GamesBloc() : super(GamesInitial()) {
    on<GamesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
