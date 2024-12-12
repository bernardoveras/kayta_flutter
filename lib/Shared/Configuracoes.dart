import 'package:kayta_flutter/Models/ConfiguracaoInicialModel.dart';
import 'package:kayta_flutter/Models/UsuarioModel.dart';
import 'package:package_info/package_info.dart';

class Configuracoes {
  static UsuarioModel? usuario;

  static String enderecoDoServidor = '';
  static String portaDoServidor = '';
  static String ambienteDoServidor = 'Local';

  static String versaoDoAplicativo = '';

  static String get url => buildUri.toString();
  static Uri get buildUri => _buildUri();

  Uri _buildUri() {
    late Uri uri;

    if (enderecoDoServidor.contains('http')) {
      uri = Uri.parse('$enderecoDoServidor:$portaDoServidor');
    } else {
      uri = Uri.http('$enderecoDoServidor:$portaDoServidor', '');
    }

    return uri;
  }

  static void fromConfiguracaoInicial(ConfiguracaoInicialModel model) {
    enderecoDoServidor = model.enderecoDoServidor;
    portaDoServidor = model.portaDoServidor;
    ambienteDoServidor = model.ambienteDoServidor;
  }

  /// Chamar este método somente no `Initializer`.
  static Future<String> obterVersaoDoAplicativo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    versaoDoAplicativo = packageInfo.version;

    return versaoDoAplicativo;
  }
}
