import 'IKaytaResponse.dart';
import '../KaytaVoidResponse/KaytaVoidResponse.dart';
import '../Mensagem.dart';

// ignore: must_be_immutable
class KaytaResponse<T> extends KaytaVoidResponse implements IKaytaResponse {
  T? value;
  KaytaResponse({
    this.value,
    List<Mensagem>? mensagens,
  }) : super(
          mensagens: mensagens,
        );

  factory KaytaResponse.sucesso(T value) => KaytaResponse<T>(value: value);

  factory KaytaResponse.erro(List<Mensagem> mensagens) => KaytaResponse(mensagens: mensagens);

  factory KaytaResponse.fromJson(Map<String, dynamic> json, T? value) {
    List<Mensagem>? mensagens;

    var mapMensagens = json['Mensagens'];

    if (mapMensagens.length > 0) {
      mensagens = (mapMensagens as List).map((e) => Mensagem.fromJson(e)).toList();
    }

    return KaytaResponse(mensagens: mensagens, value: value);
  }

  @override
  bool get hasValue => value != null;
}


