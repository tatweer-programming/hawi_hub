part of 'place__bloc.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();
}

class PlaceInitial extends PlaceState {
  @override
  List<Object> get props => [];
}

/// all Loading states will extend PlaceLoading
class PlaceLoading extends PlaceState {
  @override
  List<Object> get props => [];
}

class GetAllPlacesLoading extends PlaceLoading {
  @override
  List<Object> get props => [];
}

class GetAllPlacesSuccess extends PlaceState {
  final List<Place> places;
  const GetAllPlacesSuccess(this.places);
  @override
  List<Object> get props => [places];
}

class GetAllPlacesError extends PlaceState {
  final Exception exception;
  GetAllPlacesError(this.exception);
  @override
  List<Object> get props => [exception];
}
