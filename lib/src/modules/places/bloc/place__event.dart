part of 'place__bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();
}

class GetAllPlacesEvent extends PlaceEvent {
  final int cityId;

  const GetAllPlacesEvent(this.cityId);

  @override
  List<Object> get props => [];
}

class GetPlaceEvent extends PlaceEvent {
  final int placeId;

  const GetPlaceEvent(this.placeId);

  @override
  List<Object?> get props => [placeId];
}

class GetPlaceBookingsEvent extends PlaceEvent {
  final int placeId;

  const GetPlaceBookingsEvent(this.placeId);

  @override
  List<Object?> get props => [placeId];
}

class GetDayBookingsEvent extends PlaceEvent {
  final int placeId;
  final DateTime date;

  const GetDayBookingsEvent(this.placeId, this.date);

  @override
  List<Object?> get props => [];
}

class AddRatingEvent extends PlaceEvent {
  final double rate;

  const AddRatingEvent(
    this.rate,
  );

  @override
  List<Object?> get props => [];
}

class RatePlaceEvent extends PlaceEvent {
  final int placeId;
  final double rate;
  final String comment;

  const RatePlaceEvent(this.placeId, this.rate, this.comment);

  @override
  List<Object?> get props => [];
}

class GetPlaceReviewsEvent extends PlaceEvent {
  final int placeId;

  const GetPlaceReviewsEvent(this.placeId);

  @override
  List<Object?> get props => [];
}

class SharePlaceEvent extends PlaceEvent {
  final int placeId;

  const SharePlaceEvent({required this.placeId});

  @override
  List<Object?> get props => [];
}

class ChooseSportEvent extends PlaceEvent {
  final String sport;

  const ChooseSportEvent(this.sport);

  @override
  List<Object?> get props => [];
}

class SelectSport extends PlaceEvent {
  final int sportId;

  const SelectSport(this.sportId);

  @override
  List<Object?> get props => [sportId];
}

class AddBookingEvent extends PlaceEvent {
  final int placeId;
  final Booking booking;

  const AddBookingEvent(this.booking, {required this.placeId});

  @override
  List<Object?> get props => [];
}

class AddPlaceToFavoriteEvent extends PlaceEvent {
  final int placeId;

  const AddPlaceToFavoriteEvent(this.placeId);

  @override
  List<Object?> get props => [];
}

class DeletePlaceFromFavoriteEvent extends PlaceEvent {
  final int placeId;

  const DeletePlaceFromFavoriteEvent(this.placeId);

  @override
  List<Object?> get props => [];
}

class AddOwnerFeedbackEvent extends PlaceEvent {
  final int ownerId;
  final AppFeedBack review;

  const AddOwnerFeedbackEvent(this.ownerId, {required this.review});

  @override
  List<Object?> get props => [];
}

class AddPlaceFeedbackEvent extends PlaceEvent {
  final int placeId;
  final AppFeedBack review;

  const AddPlaceFeedbackEvent(this.placeId, {required this.review});

  @override
  List<Object?> get props => [];
}
