import 'dart:convert';
import 'IConfiguracaoInicialServiceAgent.dart';
import '../../Shared/Errors/ErrorState.dart';
import '../../Shared/Errors/Failure.dart';
import '../../Models/ConfiguracaoInicialModel.dart';
import '../../Shared/Response/KaytaResponse/KaytaResponse.dart';
import '../../Shared/Services/HttpService/IHttpService.dart';
import '../../Shared/Extensions/KaytaResponseExtension.dart';

class ConfiguracaoInicialServiceAgent implements IConfiguracaoInicialServiceAgent {
  final IHttpService httpService;

  ConfiguracaoInicialServiceAgent(this.httpService);

  @override
  Future<KaytaResponse<bool>> verificarConexao(ConfiguracaoInicialModel configuracao) async {
    try {
      var result = await httpService.get('http://${configuracao.enderecoDoServidor}:${configuracao.portaDoServidor}/keepalive');

      var body = jsonDecode(result.body);

      if (body != null) {
        var response = KaytaResponse<bool>.fromJson(body, body['HasValue'] == true ? body['Value'] : null);

        return response.verificarEContinuar<bool>();
      } else {
        throw ApiException.fromResponse(result);
      }
    } catch (e) {
      throw ErrorState.create(e);
    }
  }
}
