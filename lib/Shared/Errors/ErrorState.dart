import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:io';
import 'Failure.dart';

class ErrorState extends Equatable {
  late final String mensagem;

  ErrorState.noInternet() {
    this.mensagem = 'Internet indisponível, verifique sua conexão.';
  }

  ErrorState.create(dynamic error) {
    _logError(error);

    if (error == null) {
      this.mensagem = 'Oops, ocorreu um erro.';
    } else if (error is String) {
      this.mensagem = error.toString();
    } else if(error is ApiMessageException) {
      this.mensagem = error.mensagem;
    } else if(error is ApiFailure) {
      this.mensagem = 'Ops, servidor indisponível.';
    } else if(error is UnauthorizedFailure) {
      this.mensagem = 'Login e/ou senha inválidos.';
    }
    else if(error is MessageFailure) {
      this.mensagem = error.mensagem;
    } else if(error is Failure) {
      this.mensagem = 'Oops, ocorreu um erro.';
    } else if (error is TimeoutException) {
      this.mensagem = 'Internet indisponível, verifique sua conexão.';
    } else if (error is SocketException) {
      this.mensagem = 'Não foi possível completar sua requisição, tente novamente.';
    } else if (error is ErrorState) {
      this.mensagem = error.mensagem;
    }
    else {
      try{
        final error = jsonDecode();
        this.message = error['Mensagens'][0]['Texto'];
        return;
      }
      catch(e){}
      this.mensagem = error.toString();
    }
  }

  void _logError(error) {
    if (kDebugMode && error != null) {
      print("--- ErrorState.create ---");
      print(error);
      print("------------");
    }
  }

  @override
  List<Object> get props => [mensagem];
}
