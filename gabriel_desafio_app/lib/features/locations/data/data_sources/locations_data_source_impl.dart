// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/exceptions/exception.dart';
import '../../../../core/services/http/http_service.dart';
import '../../../../core/services/http/http_service_impl.dart';
import '../models/location_model.dart';
import 'locations_data_source.dart';

class LocationsDataSourceImpl implements LocationsDataSource {
  final HttpService _client;

  LocationsDataSourceImpl({
    HttpService? client,
  }) : _client = client ?? HttpServiceImpl.i;

  final _endPoint = 'videos/history';

  @override
  Future<List<LocationModel>> fetchLocationList([int limit = 10]) async {
    try {
      final response = await _client.get('$_endPoint?limit=$limit');

      if (response.isEmpty) {
        throw RegisterNotFoundExceptionDataSouce();
      }

      final locations = response.map((e) => LocationModel.fromMap(e)).toList();

      return locations;
    } on CustomException {
      rethrow;
    } catch (e) {
      throw CustomException(
        message: 'Error on fetch the location list',
        error: e,
      );
    }
  }
}
