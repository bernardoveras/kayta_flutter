import '../Helpers/ResponsiveFramework/ScreenUtilFramework.dart';

extension ScreenUtilExtension on num {
  /// Adaptação da largura do dispositivo de acordo com o design da UI
  ///
  /// Exemplo:
  /// ```dart
  /// Container(width: 24.width);
  /// ```
  double get width => ScreenUtilFramework().setWidth(this);

  /// Adaptação da altura do dispositivo de acordo com o design da UI
  ///
  /// Exemplo:
  /// ```dart
  /// Container(height: 24.height);
  /// ```
  double get height => ScreenUtilFramework().setHeight(this);

  /// Adaptação para o BorderRadius de acordo com o tamanho do dispositivo.
  ///
  /// Exemplo:
  /// ```dart
  /// BorderRadius.circular(8.radius);
  /// ```
  double get radius => ScreenUtilFramework().setRadius(this);

  /// Adaptação do tamanho da fonte de acordo com o tamanho do dispositivo.
  ///
  /// Exemplo:
  /// ```dart
  /// Text('Example', style: TextStyle(fontSize: 24.sp));
  /// ```
  double get sp => ScreenUtilFramework().setSp(this);
}
