part of 'place__bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();
}

class GetAllPlacesEvent extends PlaceEvent {
  @override
  List<Object> get props => [];
}

class GetPlacesEvent extends PlaceEvent {
  final int maxCount;

  const GetPlacesEvent({required this.maxCount});

  @override
  List<Object?> get props => [];
}

class GetPlaceEvent extends PlaceEvent {
  final int placeId;

  const GetPlaceEvent(this.placeId);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class BookPlaceEvent extends PlaceEvent {
  final int placeId;

  const BookPlaceEvent({required this.placeId});

  @override
  List<Object?> get props => [];
}

class SharePlaceEvent extends PlaceEvent {
  final int placeId;

  const SharePlaceEvent({required this.placeId});

  @override
  List<Object?> get props => [];
}
