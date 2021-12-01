import '../KaytaVoidResponse/IKaytaVoidResponse.dart';
import '../Mensagem.dart';

// ignore: must_be_immutable
abstract class IKaytaResponse<T> extends IKaytaVoidResponse {
  IKaytaResponse({this.value, List<Mensagem>? mensagens}) : super(mensagens: mensagens);

  final T? value;

  @override
  bool get hasValue => value != null;
}
