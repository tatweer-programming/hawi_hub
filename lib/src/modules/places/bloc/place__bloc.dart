import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hawihub/src/modules/places/data/data_source/places_remote_data_source.dart';

import '../../../core/services/dep_injection.dart';
import '../data/models/place.dart';

part 'place__event.dart';
part 'place__state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  PlacesRemoteDataSource placesRemoteDataSource = sl();

  PlaceBloc() : super(PlaceInitial()) {
    on<PlaceEvent>((event, emit) async {
      switch (event.runtimeType) {
        case GetAllPlacesEvent event:
          {
            emit(GetAllPlacesLoading());
            var result = await placesRemoteDataSource.getAllPlaces();
            result.fold((l) {
              emit(GetAllPlacesError(l));
            }, (r) {
              emit(GetAllPlacesSuccess(r));
            });
            break;
          }
        case GetPlaceEvent event:
          {
            emit(GetPlaceLoading());
            var result = await placesRemoteDataSource.getPlace(id: event.placeId);
            result.fold((l) {
              emit(GetPlaceError(l));
            }, (r) {
              emit(GetPlaceSuccess(r));
            });
            break;
          }
        case BookPlaceEvent event:
          {
            emit(BookPlaceLoading());
            var result = await placesRemoteDataSource.bookPlace(id: event.placeId);
            result.fold((l) {
              emit(BookPlaceError(l));
            }, (r) {
              emit(BookPlaceSuccess());
            });
          }
      }
    });
  }
}
