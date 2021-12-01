import '../../Models/ConfiguracaoInicialModel.dart';
import '../../ServiceAgents/Comuns/IServiceAgent.dart';
import '../../Shared/Response/KaytaResponse/KaytaResponse.dart';

abstract class IConfiguracaoInicialServiceAgent extends IServiceAgent {
  Future<KaytaResponse<bool>> verificarConexao(ConfiguracaoInicialModel configuracao);
}
