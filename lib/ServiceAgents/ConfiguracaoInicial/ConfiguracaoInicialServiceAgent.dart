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
      String _buildUrl() {
        late Uri uri;

        if (enderecoServidor.contains('http')) {
          uri = Uri.parse('${configuracao.enderecoDoServidor}:${configuracao.portaDoServidor}');
        } else {
          uri = Uri.http('${configuracao.enderecoDoServidor}:${configuracao.portaDoServidor}', '');
        }

        return uri.toString();
      }

      var result = await httpService.get('${_buildUrl}/keepalive');

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
