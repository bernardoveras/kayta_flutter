import '../Response/KaytaResponse/KaytaResponse.dart';
import '../Errors/ErrorState.dart';

typedef Task<T> = Future<T> Function();

/// Modelo para executar alguma ação.
/// Assim, podemos ter certeza de que todas as exceções são tratadas, em caso de algum erro.
/// 
/// **ALERTA:** No parâmetro `offline`, faça a checkagem pelo `NetworkService`.
Future<void> exec<T>(
  Task<KaytaResponse<T>> task, {
  /// Use o NetworkService para checkar se o usuário está offline.
  /// Exemplo:
  /// ```dart
  /// networkService.isOffline();
  /// ```
  required bool offline,
  required Function(T response) onSuccess,
  required Function(String error) onError,
  Function? onComplete,
}) async {
  try {
    if (offline == true) {
      onError(ErrorState.noInternet().mensagem);
      return null;
    }

    KaytaResponse<T> result = await task();

    if (result.ok) {
      onSuccess(result.value!);
    } else {
      onError(ErrorState.create(result.mensagens?.first.texto).mensagem);
    }
  } catch (e) {
    onError(ErrorState.create(e).mensagem);
  } finally {
    onComplete?.call();
  }
}
