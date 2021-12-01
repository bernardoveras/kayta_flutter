import 'package:kayta_flutter/Models/ConfiguracaoInicialModel.dart';
import 'package:kayta_flutter/Models/UsuarioModel.dart';
import 'package:package_info/package_info.dart';

class Configuracoes {
  static UsuarioModel? usuario;

  static String enderecoDoServidor = '';
  static String portaDoServidor = '';
  static String ambienteDoServidor = 'Local';

  static String versaoDoAplicativo = '';

  static String get url => 'http://$enderecoDoServidor:$portaDoServidor';
  static Uri get buildUri => Uri.parse('http://$enderecoDoServidor:$portaDoServidor');

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
