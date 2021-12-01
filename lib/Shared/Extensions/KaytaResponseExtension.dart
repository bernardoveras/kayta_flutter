import '../Errors/Failure.dart';
import '../Response/KaytaResponse/KaytaResponse.dart';

extension KaytaResponseExtension on KaytaResponse {
  KaytaResponse<T> verificarEContinuar<T>() {
    if (this.hasValue) {
      return (this as KaytaResponse<T>);
    } else if (this.mensagens?.isNotEmpty == true) {
      return KaytaResponse<T>.erro(this.mensagens!);
    } else {
      throw MessageFailure('Ocorreu um erro inesperado, tente novamente.');
    }
  }
}
