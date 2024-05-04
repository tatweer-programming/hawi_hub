part of 'place__bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();
}

class GetAllPlacesEvent extends PlaceEvent {
  @override
  List<Object> get props => [];
}

class GetPlaceEvent extends PlaceEvent {
  final int placeId;

  const GetPlaceEvent(this.placeId);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetCompletedDaysEvent extends PlaceEvent {
  final int placeId;
  const GetCompletedDaysEvent(this.placeId);
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
