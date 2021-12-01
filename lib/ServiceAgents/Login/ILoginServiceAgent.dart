import '../../Models/UsuarioModel.dart';
import '../../Shared/Response/KaytaResponse/KaytaResponse.dart';
import '../Comuns/IServiceAgent.dart';

abstract class ILoginServiceAgent extends IServiceAgent {
  Future<KaytaResponse<UsuarioModel>> logar(String usuario, String senha);
}
