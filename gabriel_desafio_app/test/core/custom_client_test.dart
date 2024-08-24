import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_desafio_app/core/services/http/custom_client.dart';
import 'package:gabriel_desafio_app/core/services/http/interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockInterceptor extends Mock implements Interceptor {}

class MockRequest extends Mock implements http.BaseRequest {}

class MockResponse extends Mock implements http.StreamedResponse {}

class MockClient extends Mock implements http.Client {}

void main() {
  late CustomClient customClient;
  late MockClient mockClient;
  late MockInterceptor mockInterceptor;
  late MockRequest mockRequest;
  late MockResponse mockResponse;

  setUp(() {
    mockClient = MockClient();
    mockInterceptor = MockInterceptor();
    customClient = CustomClient(mockClient, [mockInterceptor]);
    mockRequest = MockRequest();
    mockResponse = MockResponse();
    registerFallbackValue(MockRequest());
    registerFallbackValue(MockResponse());
  });

  test('should execute interceptors and forward request to inner client',
      () async {
    when(() => mockInterceptor.onRequest(any())).thenAnswer((_) async => {});
    when(() => mockInterceptor.onResponse(any())).thenAnswer((_) async => {});
    when(() => mockClient.send(any())).thenAnswer((_) async => mockResponse);

    final response = await customClient.send(mockRequest);

    verify(() => mockInterceptor.onRequest(mockRequest)).called(1);
    verify(() => mockClient.send(mockRequest)).called(1);
    expect(response, equals(mockResponse));
  });

  test('should add and remove interceptors', () {
    final anotherInterceptor = MockInterceptor();

    customClient.addInterceptor(anotherInterceptor);
    expect(customClient.inner, equals(mockClient));
    expect(customClient.interceptors.contains(anotherInterceptor), isTrue);

    customClient.removeInterceptor(anotherInterceptor);
    expect(customClient.interceptors.contains(anotherInterceptor), isFalse);
  });
}
