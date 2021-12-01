import '../Mensagem.dart';

abstract class IKaytaVoidResponse {
  IKaytaVoidResponse({this.mensagens});

  final List<Mensagem>? mensagens;

  bool get ok;
  bool get hasError;
  bool get hasValue;
}