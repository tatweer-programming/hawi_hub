part of 'place__bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();
}

class GetAllPlacesEvent extends PlaceEvent {
  @override
  List<Object> get props => [];
}
