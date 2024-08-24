import '../../../../core/exceptions/exception.dart';
import '../../domain/entities/location.dart';
import '../../domain/repositories/locations_repository.dart';
import '../data_sources/locations_data_source.dart';
import '../mapper/location_mapper.dart';

class LocationsRepositoryImpl implements LocationsRepository {
  final LocationsDataSource _dataSource;

  LocationsRepositoryImpl({required LocationsDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<List<Location>> fetchLocationList() async {
    try {
      final result = await _dataSource.fetchLocationList();
      final locations = result.map((e) => LocationMapper.toEntity(e)).toList();

      return locations;
    } on CustomException {
      rethrow;
    } catch (e) {
      throw CustomException(
        message: 'Error on transform data to entity',
        error: e,
      );
    }
  }
}
