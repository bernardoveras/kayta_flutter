import 'package:equatable/equatable.dart';
import '../Errors/ErrorState.dart';

/// Classe criada para `gerenciar o estado` de uma `View` para manter a view reativa e ciente se caso ocorrer
/// um erro, por exemplo.
// ignore: must_be_immutable
abstract class IViewState<T> extends Equatable {
  late T? _value;
  T? get value;

  late bool _loading;
  bool get loading;

  late ErrorState? _error;
  ErrorState? get error;

  IViewState();

  /// Esta função altera a variável `loading` e as outras variáveis ficam `null`.
  /// 
  /// Exemplo:
  /// ```dart
  /// IViewState.loading(true); 
  /// // loading = true; value = null; error = null;
  /// ```
  IViewState.loading(this._loading);

  /// Esta função altera a variável `value` e as outras variáveis ficam `null`.
  /// 
  /// Exemplo:
  /// ```dart
  /// IViewState.value(T); 
  /// // value = T; loading = null; error = null;
  /// ```
  IViewState.value(this._value);

  /// Esta função altera a variável `error` e as outras variáveis ficam `null`.
  /// 
  /// Exemplo:
  /// ```dart
  /// IViewState.error(ErrorState); 
  /// // error = ErrorState; loading = null; value = null;
  /// ```
  IViewState.error(this._error);

  set value(T? value);

  set loading(bool b);

  set error(ErrorState? error);

  @override
  List<Object> get props {
    List<Object> objs = <Object>[_loading];

    if (_error != null) objs.add(_error!.props);

    if (_value != null) objs.add(_value!);

    return objs;
  }

  @override
  bool get stringify => true;
}
