import 'package:dartz/dartz.dart';

import '../models/place.dart';

class PlacesRemoteDataSource {
  Future<Either<Exception, List<Place>>> getAllPlaces() {
    throw UnimplementedError();
  }

  Future<Either<Exception, Place>> getPlace({required int id}) {
    throw UnimplementedError();
  }

  Future<Either<Exception, Unit>> bookPlace({required int id}) {
    throw UnimplementedError();
  }
}
