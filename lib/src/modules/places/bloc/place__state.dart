part of 'place__bloc.dart';

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

class BookPlaceLoading extends PlaceLoading {
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

class BookPlaceError extends PlaceError {
  const BookPlaceError(super.exception);

  @override
  List<Object> get props => [
        exception,
      ];
}

class GetPlaceSuccess extends PlaceState {
  final Place place;

  const GetPlaceSuccess(this.place);

  @override
  List<Object> get props => [place];
}

class BookPlaceSuccess extends PlaceState {
  @override
  List<Object> get props => [];
}
