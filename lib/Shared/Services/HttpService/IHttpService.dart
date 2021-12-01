import 'package:http/http.dart';

abstract class IHttpService {
  IHttpService({required this.baseUrl});

  late String baseUrl;

  Future<Response> get(String rota, {Map<String, String>? headers, Duration? timeout});
  Future<Response> post(String rota, {dynamic body, Map<String, String>? headers, Duration? timeout});
}
