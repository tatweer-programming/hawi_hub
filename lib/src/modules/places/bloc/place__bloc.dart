import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/place.dart';

part 'place__event.dart';
part 'place__state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  PlaceBloc() : super(PlaceInitial()) {
    on<PlaceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
