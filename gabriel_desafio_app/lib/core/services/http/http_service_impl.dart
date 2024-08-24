import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../exceptions/exception.dart';
import 'auth_interceptor.dart';
import 'custom_client.dart';
import 'http_service.dart';
import 'models/data_response.dart';

class HttpServiceImpl implements HttpService {
  CustomClient _client;
  late String _baseUrl;
  final _defaultTimeout = const Duration(seconds: 10);
  late final AuthInterceptor _authInterceptor;

  static final HttpServiceImpl _instance = HttpServiceImpl._();

  HttpServiceImpl._() : _client = CustomClient(http.Client(), []) {
    _baseUrl = const String.fromEnvironment('BASE_URL');
    _authInterceptor = AuthInterceptor(_client);
  }
  static HttpServiceImpl get i => _instance;

  // Protected setter for testing purposes
  void setBaseUrlAndClientForTesting(String baseUrl, CustomClient client) {
    _baseUrl = baseUrl;
    _client = client;
  }

  @override
  HttpServiceImpl auth() {
    _client.addInterceptor(_authInterceptor);
    return this;
  }

  @override
  HttpServiceImpl unauth() {
    _client.removeInterceptor(_authInterceptor);
    return this;
  }

  @override
  Future<List<Map<String, dynamic>>> get(
    String url, {
    Duration? timeout,
  }) async {
    return _performRequest(() async {
      return await _client
          .get(Uri.parse('$_baseUrl/$url'))
          .timeout(timeout ?? _defaultTimeout);
    });
  }

  @override
  Future<List<Map<String, dynamic>>> delete(String url) async {
    return _performRequest(() async {
      return await _client
          .delete(Uri.parse('$_baseUrl/$url'))
          .timeout(_defaultTimeout);
    });
  }

  @override
  Future<List<Map<String, dynamic>>> post(
    String url,
    Map<String, dynamic> body,
  ) async {
    return _performRequest(() async {
      return await _client
          .post(Uri.parse('$_baseUrl/$url'), body: jsonEncode(body))
          .timeout(_defaultTimeout);
    });
  }

  @override
  Future<List<Map<String, dynamic>>> put(
    String url,
    int id,
    Map<String, dynamic> body,
  ) async {
    return _performRequest(() async {
      return await _client
          .put(Uri.parse('$_baseUrl/$url/$id'), body: jsonEncode(body))
          .timeout(_defaultTimeout);
    });
  }

  Future<List<Map<String, dynamic>>> _performRequest(
    Future<http.Response> Function() request,
  ) async {
    try {
      final response = await request();
      _handleResponse(response);

      final dataResponse = DataResponse.fromJson(response.body);

      return dataResponse.data;
    } catch (e) {
      if (e is TimeoutException) {
        log('Request timed out: $e');
        throw NetworkExceptionService(message: 'Request timed out: $e');
      }

      log('Request failed: $e');
      throw NetworkExceptionService(message: 'Request failed: $e', error: e);
    }
  }

  void _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        break;
      case 400:
        throw RegisterNotFoundExceptionService(message: response.body);
      case 401:
        throw UnauthorizedExceptionService(message: response.body);
      case 404:
        throw InvalidInputExceptionService(message: response.body);
      case 500:
      default:
        throw CustomException(
          message: '${response.statusCode}',
          prefix: 'Server error: ',
        );
    }
  }
}
