/// Serviço criado para gerenciar a conexão com a internet.
abstract class INetworkService {
  /// Utilize esse método para verificar se o usuário está com internet
  /// Exemplo:
  /// ```dart
  /// await _networkService.isOnline();
  /// ```
  Future<bool> isOnline();

  /// Utilize esse método para verificar se o usuário está sem internet
  /// Exemplo:
  /// ```dart
  /// await _networkService.isOffline();
  /// ```
  Future<bool> isOffline();
}
