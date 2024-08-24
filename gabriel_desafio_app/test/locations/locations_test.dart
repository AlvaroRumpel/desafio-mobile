import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_desafio_app/core/exceptions/exception.dart';
import 'package:gabriel_desafio_app/core/services/http/http_service.dart';
import 'package:gabriel_desafio_app/features/locations/data/data_sources/locations_data_source.dart';
import 'package:gabriel_desafio_app/features/locations/data/data_sources/locations_data_source_impl.dart';
import 'package:gabriel_desafio_app/features/locations/data/models/location_model.dart';
import 'package:gabriel_desafio_app/features/locations/data/repositories/locations_repository_impl.dart';
import 'package:gabriel_desafio_app/features/locations/domain/entities/location.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpService extends Mock implements HttpService {}

class MockLocationsDataSource extends Mock implements LocationsDataSource {}

class FakeLocationModel extends Fake implements LocationModel {}

void main() {
  late LocationsDataSourceImpl dataSource;
  late MockHttpService mockHttpService;
  late LocationsRepositoryImpl repository;
  late MockLocationsDataSource mockDataSource;
  final locationModel = LocationModel(
    uri: 'uri',
    fileName: 'fileName',
    videoInfo: VideoInfoModel(title: '', subtitle: '', description: ''),
    locationInfo: LocationInfoModel(
      id: '',
      name: '',
      address: AddressModel(
        city: '',
        state: '',
        address: '',
        latitude: '',
        longitude: '',
      ),
    ),
  );

  setUp(() {
    mockDataSource = MockLocationsDataSource();
    repository = LocationsRepositoryImpl(dataSource: mockDataSource);
    mockHttpService = MockHttpService();
    dataSource = LocationsDataSourceImpl(client: mockHttpService);
  });

  group('LocationsDataSourceImpl', () {
    test('should return a list of LocationModel when the fetch is successful',
        () async {
      // Arrange
      final location = locationModel.toMap();
      final mockResponse = [location, location];
      when(() => mockHttpService.get(any()))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await dataSource.fetchLocationList();

      // Assert
      expect(result, isA<List<LocationModel>>());
      expect(result.length, equals(2));
      expect(result[0].uri, equals('uri'));
    });

    test(
        'should throw RegisterNotFoundExceptionDataSouce when the response is empty',
        () async {
      // Arrange
      when(() => mockHttpService.get(any())).thenAnswer((_) async => []);

      // Act & Assert
      expect(
        () async => await dataSource.fetchLocationList(),
        throwsA(isA<RegisterNotFoundExceptionDataSouce>()),
      );
    });

    test('should throw CustomException when an unexpected exception occurs',
        () async {
      // Arrange
      when(() => mockHttpService.get(any()))
          .thenThrow(Exception('Unexpected error'));

      // Act & Assert
      expect(
        () async => await dataSource.fetchLocationList(),
        throwsA(isA<CustomException>()),
      );
    });
  });

  group('LocationsRepositoryImpl', () {
    test(
        'should return a list of Location when data source fetch is successful',
        () async {
      // Arrange
      final mockResponse = [locationModel, locationModel];
      // Mock the data source
      when(() => mockDataSource.fetchLocationList())
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.fetchLocationList();

      // Assert
      expect(result, isA<List<Location>>());
      expect(result.length, equals(2));
      expect(result[0].uri, equals('uri'));
    });

    test(
        'should throw RegisterNotFoundExceptionDataSouce when data source throws it',
        () async {
      // Arrange
      when(() => mockDataSource.fetchLocationList())
          .thenThrow(RegisterNotFoundExceptionDataSouce());

      // Act & Assert
      expect(
        () async => await repository.fetchLocationList(),
        throwsA(isA<RegisterNotFoundExceptionDataSouce>()),
      );
    });

    test(
        'should throw CustomException when data source throws an unexpected exception',
        () async {
      // Arrange
      when(() => mockDataSource.fetchLocationList())
          .thenThrow(Exception('Unexpected error'));

      // Act & Assert
      expect(
        () async => await repository.fetchLocationList(),
        throwsA(isA<CustomException>()),
      );
    });
  });
}
