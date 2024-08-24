import 'package:http/http.dart' as http;

abstract class Interceptor {
  Future<void> onRequest(http.BaseRequest request) async {}
  Future<void> onResponse(http.StreamedResponse response);
}
