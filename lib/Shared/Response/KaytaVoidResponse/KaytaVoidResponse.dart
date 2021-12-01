import '../BaseResponse/BaseResponse.dart';
import '../../Enums/TipoMensagem.dart';
import 'IKaytaVoidResponse.dart';
import '../Mensagem.dart';

class KaytaVoidResponse implements IKaytaVoidResponse {
  KaytaVoidResponse({List<Mensagem>? mensagens}) : _mensagens = mensagens;

  List<Mensagem>? _mensagens;

  factory KaytaVoidResponse.fromResponse(IBaseResponse response) {
    KaytaVoidResponse _response = KaytaVoidResponse.fromJson(response.body);

    return _response;
  }

  factory KaytaVoidResponse.fromJson(Map<String, dynamic> json) {
    List<Mensagem>? mensagens;

    var mapMensagens = json['Mensagens'];

    if (mapMensagens.length > 0) {
      mensagens = (mapMensagens as List).map((e) => Mensagem.fromJson(e)).toList();
    }

    return KaytaVoidResponse(mensagens: mensagens);
  }

  @override
  List<Mensagem>? get mensagens => _mensagens;

  @override
  bool get ok => !hasError;
  @override
  bool get hasError => mensagens?.any((element) => element.tipo == TipoMensagem.Erro) ?? false;
  @override
  bool get hasValue => false;
}
