import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/modules/places/data/data_source/places_remote_data_source.dart';
import 'package:hawihub/src/modules/places/data/models/booking.dart';

import '../../../core/services/dep_injection.dart';
import '../data/models/feedback.dart';
import '../data/models/place.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  List<Place> allPlaces = [];
  List<Place> viewedPlaces = [];
  Place? currentPlace;
  final PlacesRemoteDataSource placesRemoteDataSource = sl();

  PlaceBloc() : super(PlaceInitial()) {
    on<PlaceEvent>((event, emit) async {
      if (event is GetAllPlacesEvent) {
        await _handleGetAllPlacesEvent(event, emit);
      } else if (event is GetPlaceEvent) {
        await _handleGetPlaceEvent(event, emit);
      } else if (event is GetPlaceBookingsEvent) {
        await _handleGetPlaceBookingsEvent(event, emit);
      } else if (event is GetPlaceReviewsEvent) {
        await _handleGetPlaceReviewsEvent(event, emit);
      } else if (event is SelectSport) {
        _handleSelectSportEvent(event, emit);
      } else if (event is AddBookingEvent) {
        await _handleAddBookingEvent(event, emit);
      } else if (event is AddPlaceToFavoriteEvent) {
        await _handleAddPlaceToFavoriteEvent(event, emit);
      } else if (event is DeletePlaceFromFavoriteEvent) {
        await _handleDeletePlaceFromFavoriteEvent(event, emit);
      } else if (event is AddOwnerFeedbackEvent) {
        await _handleAddOwnerFeedbackEvent(event, emit);
      } else if (event is AddPlaceFeedbackEvent) {
        await _handleAddPlaceFeedbackEvent(event, emit);
      }
    });
  }

  // Event Handlers

  Future<void> _handleGetAllPlacesEvent(
      GetAllPlacesEvent event, Emitter<PlaceState> emit) async {
    if (allPlaces.isEmpty || event.refresh) {
      emit(GetAllPlacesLoading());
      var result =
          await placesRemoteDataSource.getAllPlaces(cityId: event.cityId);
      result.fold(
        (error) => emit(GetAllPlacesError(error)),
        (places) {
          allPlaces = places;
          viewedPlaces = places;
          emit(GetAllPlacesSuccess(places));
        },
      );
    }
  }

  Future<void> _handleGetPlaceEvent(
      GetPlaceEvent event, Emitter<PlaceState> emit) async {
    emit(GetPlaceLoading());
    var result = await placesRemoteDataSource.getPlace(id: event.placeId);
    result.fold(
      (error) => emit(GetPlaceError(error)),
      (place) {
        currentPlace = place;
        emit(GetPlaceSuccess(place));
      },
    );
  }

  Future<void> _handleGetPlaceBookingsEvent(
      GetPlaceBookingsEvent event, Emitter<PlaceState> emit) async {
    emit(GetPlaceBookingsLoading());
    var result =
        await placesRemoteDataSource.getPlaceBookings(placeId: event.placeId);
    result.fold(
      (error) => emit(GetPlaceBookingsError(error)),
      (bookings) => emit(GetPlaceBookingsSuccess(bookings)),
    );
  }

  Future<void> _handleGetPlaceReviewsEvent(
      GetPlaceReviewsEvent event, Emitter<PlaceState> emit) async {
    emit(GetPlaceReviewsLoading());
    var result =
        await placesRemoteDataSource.getPlaceReviews(placeId: event.placeId);
    result.fold(
      (error) => emit(GetPlaceReviewsError(error)),
      (reviews) {
        emit(GetPlaceReviewsSuccess(reviews));
      },
    );
  }

  void _handleSelectSportEvent(SelectSport event, Emitter<PlaceState> emit) {
    if (event.sportId == -1) {
      viewedPlaces = allPlaces;
      emit(const SelectSportSuccess(-1));
    } else {
      viewedPlaces =
          allPlaces.where((place) => place.sport == event.sportId).toList();
      emit(SelectSportSuccess(event.sportId));
    }
  }

  Future<void> _handleAddBookingEvent(
      AddBookingEvent event, Emitter<PlaceState> emit) async {
    emit(SendBookingRequestLoading());
    var result = await placesRemoteDataSource.addBooking(
      ownerId: allPlaces.firstWhere((e) => e.id == event.placeId).ownerId,
      booking: event.booking,
      placeId: event.placeId,
    );
    result.fold(
      (error) => emit(SendBookingRequestError(error)),
      (_) {
        emit(SendBookingRequestSuccess());
      },
    );
  }

  Future<void> _handleAddPlaceToFavoriteEvent(
      AddPlaceToFavoriteEvent event, Emitter<PlaceState> emit) async {
    emit(AddPlaceToFavouritesLoading());
    var result =
        await placesRemoteDataSource.addPlaceToFavorite(placeId: event.placeId);
    result.fold(
      (error) => emit(AddPlaceToFavouritesError(error)),
      (_) {
        ConstantsManager.appUser!.favoritePlaces.add(event.placeId);
        emit(AddPlaceToFavouritesSuccess(event.placeId));
      },
    );
  }

  Future<void> _handleDeletePlaceFromFavoriteEvent(
      DeletePlaceFromFavoriteEvent event, Emitter<PlaceState> emit) async {
    emit(DeletePlaceFromFavouritesLoading());
    var result = await placesRemoteDataSource.removePlaceFromFavorite(
        placeId: event.placeId);
    result.fold(
      (error) => emit(DeletePlaceFromFavouritesError(error)),
      (_) {
        ConstantsManager.appUser!.favoritePlaces.remove(event.placeId);
        emit(DeletePlaceFromFavouritesSuccess(event.placeId));
      },
    );
  }

  Future<void> _handleAddOwnerFeedbackEvent(
      AddOwnerFeedbackEvent event, Emitter<PlaceState> emit) async {
    emit(AddOwnerFeedbackLoading());
    var result = await placesRemoteDataSource.addOwnerFeedback(
      event.ownerId,
      review: event.review,
    );
    result.fold(
      (error) => emit(AddOwnerFeedbackError(error)),
      (_) => emit(AddOwnerFeedbackSuccess()),
    );
  }

  Future<void> _handleAddPlaceFeedbackEvent(
      AddPlaceFeedbackEvent event, Emitter<PlaceState> emit) async {
    emit(AddPlaceFeedbackLoading());
    var result = await placesRemoteDataSource.addPlaceFeedback(
      event.placeId,
      review: event.review,
    );
    result.fold(
      (error) => emit(AddPlaceFeedbackError(error)),
      (_) => emit(AddPlaceFeedbackSuccess()),
    );
  }

  // Singleton pattern for accessing the bloc instance
  static PlaceBloc? _bloc;

  static PlaceBloc get() {
    _bloc ??= PlaceBloc();
    return _bloc!;
  }
}