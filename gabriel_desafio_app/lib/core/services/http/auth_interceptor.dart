import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../exceptions/exception.dart';
import 'custom_client.dart';
import 'interceptor.dart';

// ignore: constant_identifier_names
const _ACCESS_TOKEN = 'access_token';
// ignore: constant_identifier_names
const _REFRESH_TOKEN = 'refresh_token';

class AuthInterceptor extends Interceptor {
  final CustomClient client;
  static const _secureStorage = FlutterSecureStorage();

  AuthInterceptor(this.client);

  @override
  Future<void> onRequest(http.BaseRequest request) async {
    try {
      final accessToken = await _secureStorage.read(key: _ACCESS_TOKEN);
      if (accessToken != null && accessToken.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }
    } catch (e, s) {
      log('Error onRequest AuthInterceptor', error: e, stackTrace: s);
    }
  }

  @override
  Future<void> onResponse(http.StreamedResponse response) async {
    if (response.statusCode == 401 || response.statusCode == 403) {
      response = await _handle40x(response.request!);
    }
  }

  Future<http.StreamedResponse> _handle40x(http.BaseRequest request) async {
    final refreshToken = await _secureStorage.read(key: _REFRESH_TOKEN);
    if (refreshToken == null) {
      throw UnauthorizedExceptionService(message: 'User not authorized');
    }

    final accessToken = await _secureStorage.read(key: _ACCESS_TOKEN);

    final refreshResponse = await client.inner.put(
      Uri.parse('${request.url.origin}/auth/refresh'),
      headers: {'authorization': 'Bearer $accessToken'},
      body: jsonEncode({_REFRESH_TOKEN: refreshToken}),
    );

    if (refreshResponse.statusCode == 200) {
      final newAccessToken = jsonDecode(refreshResponse.body)[_ACCESS_TOKEN];
      final newRefreshToken = jsonDecode(refreshResponse.body)[_REFRESH_TOKEN];

      await Future.wait([
        _secureStorage.write(key: _ACCESS_TOKEN, value: newAccessToken),
        _secureStorage.write(key: _REFRESH_TOKEN, value: newRefreshToken),
      ]);

      request.headers['Authorization'] = 'Bearer $newAccessToken';
      final newResponse = await client.send(request);
      return newResponse;
    }

    throw UnauthorizedExceptionService(message: 'Fail on try refresh token');
  }
}
