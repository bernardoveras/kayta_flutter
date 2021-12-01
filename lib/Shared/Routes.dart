abstract class IRoutes {
  static const CONFIGURACAO_INICIAL = '/configuracao_inicial';
  static const LOGIN = '/login';
  static const HOME = '/home';

  String get initialRoute;
  List get routes;

  bool contains(String route) {
    if (route == LOGIN) return true;
    if (route == CONFIGURACAO_INICIAL) return true;
    if (route == HOME) return true;

    return false;
  }
}