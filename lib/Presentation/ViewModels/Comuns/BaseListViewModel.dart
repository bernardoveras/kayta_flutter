import 'package:kayta_flutter/kayta_flutter.dart';

import '../../../Shared/Utils/ViewState.dart';
import '../../ViewModels/Comuns/IViewModel.dart';
import '../../../Shared/Extensions/ViewStateExtension.dart';

abstract class BaseListViewModel<TServiceAgent extends IServiceAgent, TModel> extends IViewModel {
  BaseListViewModel() {
    this.onReady();
  }

  TServiceAgent get serviceAgent;
  INetworkService get networkService;

  late IViewState<List<TModel>> state;

  Future<void> atualizar() async => await _pesquisarEAtualizar();
  Future<KaytaResponse<List<TModel>>> pesquisar();

  Future<void> _pesquisarEAtualizar() async {
    bool offline = await networkService.isOffline();

    return await state.update(() => pesquisar(), offline: offline);
  }

  @override
  void onReady() async {
    await _pesquisarEAtualizar();
  }
}
