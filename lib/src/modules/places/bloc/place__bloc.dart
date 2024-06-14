import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/modules/places/data/data_source/places_remote_data_source.dart';
import 'package:hawihub/src/modules/places/data/models/booking.dart';

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
        var result = await placesRemoteDataSource.getAllPlaces(cityId: event.cityId);
        result.fold((l) {
          errorToast(msg: "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
          emit(GetAllPlacesError(l));
        }, (r) {
          allPlaces = r;
          print(r);
          viewedPlaces = r;
          emit(GetAllPlacesSuccess(r));
        });
      } else if (event is GetPlaceEvent) {
        emit(GetPlaceLoading());
        var result = await placesRemoteDataSource.getPlace(id: event.placeId);
        result.fold((l) {
          emit(GetPlaceError(l));
        }, (r) {
          currentPlace = r;
          emit(GetPlaceSuccess(r));
        });
      } else if (event is GetPlaceBookingsEvent) {
        emit(GetPlaceBookingsLoading());
        var result = await placesRemoteDataSource.getPlaceBookings(placeId: event.placeId);
        result.fold((l) {
          emit(GetPlaceBookingsError(l));
        }, (r) {
          emit(GetPlaceBookingsSuccess(r));
        });
      }
      // else if (event is GetDayBookingsEvent) {
      //   emit(GetDayBookingsLoading());
      //   var result =
      //   await placesRemoteDataSource.ge(date: event.date, placeId: event.placeId);
      //   result.fold((l) {
      //     emit(GetDayBookingsError(l));
      //   }, (r) {
      //     emit(GetDayBookingsSuccess(r));
      //   });
      // }
      else if (event is GetPlaceReviewsEvent) {
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
      } else if (event is SelectSport) {
        if (event.sportId == -1) {
          viewedPlaces = allPlaces;
          emit(const SelectSportSuccess(-1));
          print(allPlaces);
        } else {
           viewedPlaces = allPlaces.where((element) => element.sport == event.sportId).toList();
          print(allPlaces);
           emit(SelectSportSuccess(event.sportId));
           print(state);
        }
      }
      else if (event is AddBookingEvent) {
        emit(SendBookingRequestLoading());
        var result = await placesRemoteDataSource.addBooking(booking: event.booking , placeId: event.placeId );
        result.fold((l) {
          emit(SendBookingRequestError(l));
        }, (r) {
          emit(SendBookingRequestSuccess());
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
