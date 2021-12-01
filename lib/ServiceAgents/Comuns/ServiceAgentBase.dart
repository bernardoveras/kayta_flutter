import '../../Shared/Services/HttpService/IHttpService.dart';
import 'IServiceAgent.dart';

/// Esta função será usada em um `ServiceAgent` para fazer as requisições `Http` com o `HttpService`.
/// 
/// Parâmetros:
/// - ClientName: Em andamento...
/// - Resource: A rota em que deseja fazer a requisição. `Ex: "empresas"`
/// - ambienteDoServidor: Ambiente do servidor. `Ex: "Local"`
/// 
/// Exemplo:
/// ```dart
/// class LoginServiceAgent extends ServiceAgentBase<UsuarioModel> implements ILoginServiceAgent {
///   LoginServiceAgent({
///   required IHttpService httpService,
///   String resource = 'seguranca/controleacesso/usuarios/autenticar',
///   required String ambienteDoServidor,
///   }) : super(
///     clientName: '',
///     httpService: httpService,
///     resource: resource,
///     ambienteDoServidor: ambienteDoServidor,
///   );
/// ```
abstract class ServiceAgentBase<T> extends IServiceAgent {
  late IHttpService httpService;

  late String resource;
  late String clientName;
  late String ambienteDoServidor;

  ServiceAgentBase({
    required this.resource,
    required this.clientName,
    required this.httpService,
    required this.ambienteDoServidor,
  });

  T fromJson(Map<String, dynamic> json);
}
