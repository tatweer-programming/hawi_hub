import 'package:get_it/get_it.dart';
import 'package:hawihub/src/modules/places/data/data_source/places_remote_data_source.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    PlacesRemoteDataSource placesRemoteDataSource = PlacesRemoteDataSource();
    sl.registerLazySingleton(() => placesRemoteDataSource);
  }
}
