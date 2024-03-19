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
  const GetPlaceEvent({required this.placeId});

  @override
  List<Object?> get props => throw UnimplementedError();
}
