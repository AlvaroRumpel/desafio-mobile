import '../models/location_model.dart';

abstract interface class LocationsDataSource {
  Future<List<LocationModel>> fetchLocationList([int limit = 10]);
}
