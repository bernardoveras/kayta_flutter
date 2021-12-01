import 'dart:async';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:kayta_flutter/Shared/Errors/ErrorState.dart';
import 'package:kayta_flutter/Shared/Errors/Failure.dart';

class TestFailure extends Failure {}

main() {
  test('Deve retornar mensagens corretas - Geral', () {
    expect(ErrorState.noInternet().mensagem, 'Internet indisponível, verifique sua conexão.');

    expect(ErrorState.create(null).mensagem, 'Oops, ocorreu um erro.');

    expect(ErrorState.create("error").mensagem, "error");

    expect(ErrorState.create(123).mensagem, 'Oops, ocorreu um erro.');
  });

  test('Deve retornar mensagens corretas para exceções', () {

    expect(ErrorState.create(ApiMessageException(statusCode: 200, mensagem: "Error")).mensagem, "Error");

    expect(ErrorState.create(TimeoutException("")).mensagem, 'Internet indisponível, verifique sua conexão.');

    expect(ErrorState.create(SocketException("")).mensagem, 'Não foi possível completar sua requisição, tente novamente.');
  });

  test('Deve retornar mensagens corretas para Failures', () {

    expect(ErrorState.create(ApiFailure()).mensagem, 'Ops, servidor indisponível.');

    expect(ErrorState.create(MessageFailure("Error")).mensagem, "Error");

    expect(ErrorState.create(TestFailure()).mensagem, 'Oops, ocorreu um erro.');
  });

  test('equals test', () {
    var error1 = ErrorState.noInternet();
    var error2 = ErrorState.noInternet();

    expect(error1, error2);
  });
}
