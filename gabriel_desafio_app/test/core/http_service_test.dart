import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_desafio_app/core/services/http/auth_interceptor.dart';
import 'package:gabriel_desafio_app/core/services/http/custom_client.dart';
import 'package:gabriel_desafio_app/core/services/http/http_service_impl.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockCustomClient extends Mock implements CustomClient {}

class MockResponse extends Mock implements http.Response {}

class MockAuthInterceptor extends Mock implements AuthInterceptor {}

void main() {
  late HttpServiceImpl httpServiceImpl;
  late MockCustomClient mockClient;
  late MockResponse mockResponse;

  setUp(() {
    mockClient = MockCustomClient();
    mockResponse = MockResponse();
    httpServiceImpl = HttpServiceImpl.i;
    httpServiceImpl.setBaseUrlAndClientForTesting(
      'https://exemple.com',
      mockClient,
    );

    registerFallbackValue(Uri());
  });

  test('should perform GET request and return data', () async {
    // Mock a valid JSON response for the GET request
    when(() => mockClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => mockResponse);

    // Ensure the mocked response body is a valid JSON string
    when(() => mockResponse.body).thenReturn(
      '{"data": [], "status":{"message": "teste", "code": 200}}',
    );
    when(() => mockResponse.statusCode).thenReturn(200);

    // Perform the GET request
    final result = await httpServiceImpl.get('test_url');

    // Assertions
    expect(result, isA<List<Map<String, dynamic>>>());
    verify(() => mockClient.get(any(), headers: any(named: 'headers')))
        .called(1);
  });

  test('should throw an exception for unsuccessful GET request', () async {
    when(() => mockClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => mockResponse);
    when(() => mockResponse.statusCode).thenReturn(500);

    expect(() => httpServiceImpl.get('test_url'), throwsException);
    verify(() => mockClient.get(any(), headers: any(named: 'headers')))
        .called(1);
  });
}
