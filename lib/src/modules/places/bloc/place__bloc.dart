import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hawihub/src/modules/places/data/data_source/places_remote_data_source.dart';

import '../../../core/services/dep_injection.dart';
import '../data/models/feedback.dart';
import '../data/models/place.dart';

part 'place__event.dart';
part 'place__state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  List<Place> allPlaces = [];
  List<Place> viewedPlaces = [];
  Place? currentPlace;
  PlacesRemoteDataSource placesRemoteDataSource = sl();
  PlaceBloc() : super(PlaceInitial()) {
    on<PlaceEvent>((event, emit) async {
      if (event is GetAllPlacesEvent) {
        emit(GetAllPlacesLoading());
        var result = await placesRemoteDataSource.getAllPlaces();
        result.fold((l) {
          emit(GetAllPlacesError(l));
        }, (r) {
          allPlaces = r;
          viewedPlaces = allPlaces;
          emit(GetAllPlacesSuccess(r));
        });
      } else if (event is GetPlaceEvent) {
        emit(GetPlaceLoading());
        var result = await placesRemoteDataSource.getPlace(id: event.placeId);
        result.fold((l) {
          emit(GetPlaceError(l));
        }, (r) {
          emit(GetPlaceSuccess(r));
        });
      } else if (event is GetCompletedDaysEvent) {
        emit(GetCompletedDaysLoading());
        var result = await placesRemoteDataSource.getCompletedDays(placeId: event.placeId);
        result.fold((l) {
          emit(GetCompletedDaysError(l));
        }, (r) {
          emit(GetCompletedDaysSuccess(r));
        });
      } else if (event is GetDayBookingsEvent) {
        emit(GetDayBookingsLoading());
        var result =
            await placesRemoteDataSource.getDayBookings(date: event.date, placeId: event.placeId);
        result.fold((l) {
          emit(GetDayBookingsError(l));
        }, (r) {
          emit(GetDayBookingsSuccess(r));
        });
      } else if (event is GetPlaceReviewsEvent) {
        emit(GetPlaceReviewsLoading());
        var result = await placesRemoteDataSource.getPlaceReviews(placeId: event.placeId);
        result.fold((l) {
          emit(GetPlaceReviewsError(l));
        }, (r) {
          emit(GetPlaceReviewsSuccess(r));
        });
      } else if (event is RatePlaceEvent) {
        FeedBack feedBack = FeedBack.create(rating: event.rate, comment: event.comment);
        emit(RatePlaceLoading());
        var result =
            await placesRemoteDataSource.ratePlace(feedBack: feedBack, placeId: event.placeId);
        result.fold((l) {
          emit(RatePlaceError(l));
        }, (r) {
          emit(RatePlaceSuccess());
        });
      }
    });
  }
  static PlaceBloc? bloc;
  static PlaceBloc get() {
    bloc ??= PlaceBloc();
    return bloc!;
  }
}
