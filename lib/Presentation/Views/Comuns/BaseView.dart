import 'package:flutter/material.dart';
import '../../ViewModels/Comuns/IViewModel.dart';

/// Interface criada para padronizar a nomenclatura `ViewModel` nas View's
/// Ele é um `StatelessWidget` porém com a `instância da ViewModel` já obtida.
// ignore: must_be_immutable
abstract class BaseView<TViewModel extends IViewModel> extends StatelessWidget {
  /// ViewModel correspondente ao tipo genérico passado no `BaseView<TViewModel>`
  TViewModel get viewModel;

  @override
  Widget build(BuildContext context);
}
