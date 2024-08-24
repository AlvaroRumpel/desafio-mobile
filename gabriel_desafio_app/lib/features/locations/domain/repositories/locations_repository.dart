import '../entities/location.dart';

abstract interface class LocationsRepository {
  Future<List<Location>> fetchLocationList();
}
