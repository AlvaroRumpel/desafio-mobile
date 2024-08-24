abstract interface class HttpService {
  HttpService auth();
  HttpService unauth();
  Future<List<Map<String, dynamic>>> get(String url);
  Future<List<Map<String, dynamic>>> post(
    String url,
    Map<String, dynamic> body,
  );
  Future<List<Map<String, dynamic>>> put(
    String url,
    int id,
    Map<String, dynamic> body,
  );
  Future<List<Map<String, dynamic>>> delete(String url);
}
