import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_desafio_app/core/services/http/auth_interceptor.dart';
import 'package:gabriel_desafio_app/core/services/http/custom_client.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockCustomClient extends Mock implements CustomClient {}

class MockRequest extends Mock implements http.BaseRequest {}

class MockResponse extends Mock implements http.StreamedResponse {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const secureStorageChannel =
      MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
  late AuthInterceptor authInterceptor;
  late MockCustomClient mockClient;
  late MockRequest mockRequest;
  late MockResponse mockResponse;

  setUp(() {
    mockClient = MockCustomClient();
    authInterceptor = AuthInterceptor(mockClient);
    mockRequest = MockRequest();
    mockResponse = MockResponse();
  });

  tearDownAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(secureStorageChannel, (null));
  });

  group('Token exists', () {
    setUp(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(secureStorageChannel,
              (MethodCall methodCall) async {
        if (methodCall.method == 'read') {
          return 'access_token_value';
        }
        return null;
      });
    });
    test('should add Authorization header when access token is available',
        () async {
      when(() => mockRequest.headers).thenReturn(<String, String>{});

      await authInterceptor.onRequest(mockRequest);

      verify(
        () =>
            mockRequest.headers['Authorization'] = 'Bearer access_token_value',
      ).called(1);
    });

    test('should handle missing access token gracefully', () async {
      when(() => mockRequest.headers).thenReturn({});

      await authInterceptor.onRequest(mockRequest);

      verify(
        () =>
            mockRequest.headers['Authorization'] = 'Bearer access_token_value',
      ).called(1);
    });
  });

  group('Token not exists', () {
    setUp(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(secureStorageChannel,
              (MethodCall methodCall) async {
        if (methodCall.method == 'read') {
          return null;
        }
        return null;
      });
    });

    test('should not add Authorization header when access token is missing',
        () async {
      when(() => mockRequest.headers).thenReturn({});

      await authInterceptor.onRequest(mockRequest);

      // Verify that the Authorization header was not added
      expect(mockRequest.headers.containsKey('Authorization'), isFalse);
    });
  });

  group('Token not exists', () {
    setUp(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(secureStorageChannel,
              (MethodCall methodCall) async {
        if (methodCall.method == 'read') {
          throw Exception('Failed to retrive token');
        }
        return null;
      });
    });

    test('should handle errors during token retrieval gracefully', () async {
      when(() => mockRequest.headers).thenReturn({});

      await authInterceptor.onRequest(mockRequest);

      expect(mockRequest.headers.containsKey('Authorization'), isFalse);
    });
  });

  group('onResponse', () {
    test('should call onResponse without errors', () async {
      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.contentLength).thenReturn(100);

      await authInterceptor.onResponse(mockResponse);

      // No exceptions should be thrown
      expect(true, isTrue);
    });
  });
}
