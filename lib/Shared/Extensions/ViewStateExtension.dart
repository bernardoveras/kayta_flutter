import '../Response/KaytaResponse/KaytaResponse.dart';
import '../Errors/ErrorState.dart';
import '../Utils/Task.dart';
import '../Utils/ViewState.dart';

extension ViewStateExtension on IViewState {
  /// Método útil para chamar alguma tarefa e definir o resultado no ViewState automaticamente.
  ///
  /// **ALERTA:** No parâmetro `offline`, faça a checkagem pelo `NetworkService`.
  Future<void> update<T>(
    Task<KaytaResponse<T>> task, {
    required bool offline,
    Function? onComplete,
  }) async {
    this.loading = true;

    return await exec(
      task,
      onSuccess: (result) => this.value = result,
      onError: (error) => ErrorState.create(error),
      onComplete: onComplete,
      offline: offline,
    );
  }
}
