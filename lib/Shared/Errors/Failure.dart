import 'dart:convert';
import 'package:http/http.dart';

abstract class Failure implements Exception {
  @override
  String toString() => '$runtimeType Exception';
}

class GenericFailure extends Failure {}

class TimeoutFailure extends Failure {}

class ApiFailure extends Failure {
  final Failure? error;

  ApiFailure({this.error});
}
class NetworkFailure extends Failure {
  final String? mensagem;

  NetworkFailure([this.mensagem]);
}

class RouteNotFoundFailure extends Failure {
  final String rota;

  RouteNotFoundFailure(this.rota);
}

class MessageFailure extends Failure {
  final String mensagem;

  MessageFailure(this.mensagem);
}

class UnauthorizedFailure extends Failure {
  final String mensagem;

  UnauthorizedFailure(this.mensagem);
}

class ApiException implements Exception {
  final String? msg;
  final int? statusCode;

  ApiException({required this.statusCode, this.msg});

  ApiException.fromResponse(Response response)
      : this.statusCode = response.statusCode,
        this.msg = jsonDecode(response.body);
}

class ApiMessageException implements Exception {
  final String mensagem;
  final int statusCode;

  ApiMessageException({required this.statusCode, required this.mensagem});
}
