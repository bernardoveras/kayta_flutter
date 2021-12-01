import 'dart:convert';
import '../../Models/UsuarioModel.dart';
import '../../ServiceAgents/Comuns/ServiceAgentBase.dart';
import '../../Shared/Errors/ErrorState.dart';
import '../../Shared/Errors/Failure.dart';
import '../../Shared/Response/KaytaResponse/KaytaResponse.dart';
import '../../Shared/Services/HttpService/IHttpService.dart';
import '../../Shared/Extensions/KaytaResponseExtension.dart';
import 'ILoginServiceAgent.dart';

class LoginServiceAgent extends ServiceAgentBase<UsuarioModel> implements ILoginServiceAgent {
  LoginServiceAgent({
    required IHttpService httpService,
    String resource = 'seguranca/controleacesso/usuarios/autenticar',
    required String ambienteDoServidor,
  }) : super(
          clientName: '',
          httpService: httpService,
          resource: resource,
          ambienteDoServidor: ambienteDoServidor,
        );

  @override
  Future<KaytaResponse<UsuarioModel>> logar(String login, String senha) async {
    try {
      var result = await httpService.post(
        resource,
        body: jsonEncode({'login': login, 'senha': senha}),
        headers: {
          'Authorization': _gerarBase64(login, senha),
          'X-Ambiente': ambienteDoServidor,
        },
      );

      var body = jsonDecode(result.body);

      if (body != null) {
        var response = UsuarioModel.toKaytaResponse(body);

        return response.verificarEContinuar<UsuarioModel>();
      } else {
        throw ApiException.fromResponse(result);
      }
    } catch (e) {
      throw ErrorState.create(e);
    }
  }

  String _gerarBase64(String login, String senha) {
    var str = '$login:$senha';
    var bytes = utf8.encode(str);
    return "Basic ${base64.encode(bytes)}";
  }

  @override
  UsuarioModel fromJson(Map<String, dynamic> json) => UsuarioModel.fromJson(json['Value']);
}
