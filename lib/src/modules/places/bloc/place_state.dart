part of 'place_bloc.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();
}

class PlaceInitial extends PlaceState {
  @override
  List<Object> get props => [];
}

/// all Loading states will extend PlaceLoading
abstract class PlaceLoading extends PlaceState {
  @override
  List<Object> get props => [];
}

class GetAllPlacesLoading extends PlaceLoading {
  @override
  List<Object> get props => [];
}

class GetPlaceLoading extends PlaceLoading {
  @override
  List<Object> get props => [];
}

class GetDayBookingsLoading extends PlaceLoading {
  @override
  List<Object> get props => [];
}

class GetAllPlacesSuccess extends PlaceState {
  final List<Place> places;

  const GetAllPlacesSuccess(this.places);

  @override
  List<Object> get props => [places];
}

/// all Error states will extend PlaceError
class PlaceError extends PlaceState {
  final Exception exception;

  const PlaceError(this.exception);

  @override
  List<Object> get props => [exception];
}

class GetPlaceError extends PlaceError {
  const GetPlaceError(super.exception);

  @override
  List<Object> get props => [exception];
}

class GetAllPlacesError extends PlaceError {
  const GetAllPlacesError(super.exception);

  @override
  List<Object> get props => [exception];
}

class GetPlaceSuccess extends PlaceState {
  final Place place;

  const GetPlaceSuccess(this.place);

  @override
  List<Object> get props => [place];
}

class GetPlaceBookingsSuccess extends PlaceState {
  final List<PlaceBooking> bookings;

  const GetPlaceBookingsSuccess(this.bookings);

  @override
  List<Object> get props => [bookings];
}

class GetPlaceBookingsError extends PlaceError {
  const GetPlaceBookingsError(super.exception);

  @override
  List<Object> get props => [exception];
}

class GetPlaceBookingsLoading extends PlaceLoading {
  @override
  List<Object> get props => [];
}

class GetDayBookingsSuccess extends PlaceState {
  final List<DateTime> days;

  const GetDayBookingsSuccess(this.days);

  @override
  List<Object> get props => [days];
}

class GetDayBookingsError extends PlaceError {
  const GetDayBookingsError(super.exception);

  @override
  List<Object> get props => [exception];
}

class GetPlaceReviewsLoading extends PlaceLoading {
  @override
  List<Object> get props => [];
}

class GetPlaceReviewsSuccess extends PlaceState {
  final List<AppFeedBack> feedBacks;

  const GetPlaceReviewsSuccess(this.feedBacks);

  @override
  List<Object> get props => [feedBacks];
}

class GetPlaceReviewsError extends PlaceError {
  const GetPlaceReviewsError(super.exception);

  @override
  List<Object> get props => [exception];
}

class RatePlaceLoading extends PlaceLoading {
  @override
  List<Object> get props => [];
}

class RatePlaceSuccess extends PlaceState {
  @override
  List<Object> get props => [];
}

class RatePlaceError extends PlaceError {
  const RatePlaceError(super.exception);

  @override
  List<Object> get props => [exception];
}

class SendBookingRequestLoading extends PlaceLoading {
  @override
  List<Object> get props => [];
}

class SendBookingRequestSuccess extends PlaceState {
  @override
  List<Object> get props => [];
}

class SendBookingRequestError extends PlaceError {
  const SendBookingRequestError(super.exception);

  @override
  List<Object> get props => [exception];
}

class SelectPlaceSportSuccess extends PlaceState {
  final int sportId;

  const SelectPlaceSportSuccess(this.sportId);

  @override
  List<Object> get props => [
        sportId,
      ];
}

class SelectPlacesSportLoading extends PlaceState {
  final int sportId;

  const SelectPlacesSportLoading(this.sportId);

  @override
  List<Object> get props => [
        sportId,
      ];
}

class AddPlaceToFavouritesSuccess extends PlaceState {
  final int placeId;

  const AddPlaceToFavouritesSuccess(this.placeId);

  @override
  List<Object> get props => [
        placeId,
      ];
}

class AddPlaceToFavouritesError extends PlaceError {
  const AddPlaceToFavouritesError(super.exception);

  @override
  List<Object> get props => [exception];
}

class AddPlaceToFavouritesLoading extends PlaceLoading {
  @override
  List<Object> get props => [];
}

class DeletePlaceFromFavouritesSuccess extends PlaceState {
  final int placeId;

  const DeletePlaceFromFavouritesSuccess(this.placeId);

  @override
  List<Object> get props => [
        placeId,
      ];
}

class DeletePlaceFromFavouritesError extends PlaceError {
  const DeletePlaceFromFavouritesError(super.exception);

  @override
  List<Object> get props => [exception];
}

class DeletePlaceFromFavouritesLoading extends PlaceLoading {
  @override
  List<Object> get props => [];
}

class AddPlaceFeedbackSuccess extends PlaceState {
  @override
  List<Object> get props => [];
}

class AddPlaceFeedbackError extends PlaceError {
  const AddPlaceFeedbackError(super.exception);

  @override
  List<Object> get props => [exception];
}

class AddPlaceFeedbackLoading extends PlaceLoading {
  @override
  List<Object> get props => [];
}

class AddOwnerFeedbackSuccess extends PlaceState {
  @override
  List<Object> get props => [];
}

class AddOwnerFeedbackError extends PlaceError {
  const AddOwnerFeedbackError(super.exception);

  @override
  List<Object> get props => [exception];
}

class AddOwnerFeedbackLoading extends PlaceLoading {
  @override
  List<Object> get props => [];
}

class AddRatingState extends PlaceLoading {
  final double rating;

  AddRatingState(this.rating);

  @override
  List<Object> get props => [rating];
}
