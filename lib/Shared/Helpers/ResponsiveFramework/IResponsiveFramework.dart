abstract class IResponsiveFramework {
  /// Adaptação da largura do dispositivo de acordo com o design da UI
  double setWidth(num width);

  /// Adaptação da altura do dispositivo de acordo com o design da UI
  double setHeight(num width);

  /// Adaptação para o BorderRadius de acordo com o tamanho do dispositivo.
  double setRadius(num width);

  /// Adaptação do tamanho da fonte de acordo com o tamanho do dispositivo.
  double setSp(num width);
}