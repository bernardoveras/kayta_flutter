import '../../../Shared/Utils/ViewState.dart';
import '../../../ServiceAgents/Comuns/IServiceAgent.dart';
import 'IViewModel.dart';

abstract class BaseViewModel<TServiceAgent extends IServiceAgent, TModel> extends IViewModel {
  BaseViewModel({
    required this.serviceAgent,
    required this.state,
  });

  final TServiceAgent serviceAgent;

  final IViewState<TModel> state;
}
