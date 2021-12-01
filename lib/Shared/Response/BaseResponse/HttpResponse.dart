import 'package:http/http.dart';
import 'dart:convert';
import 'BaseResponse.dart';

/// Classe usada para quando usar o package `http`.
class HttpResponse implements IBaseResponse {
  HttpResponse(
    Map<String, dynamic> body,
    int statusCode,
  ) {
    this.body = body;
    this.statusCode = statusCode;
  }

  @override
  late Map<String, dynamic> body;

  @override
  late int statusCode;

  factory HttpResponse.fromResponse(Response response) {
    final Map<String, dynamic> body = jsonDecode(response.body) ?? {};
    final int statusCode = response.statusCode;

    return HttpResponse(body, statusCode);
  }
}
