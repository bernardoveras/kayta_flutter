enum TipoMensagem {
  Alerta,
  Sucesso,
  Erro,
  ErroCritico,
  Info,
  ErroPermissaoNegada,
}

extension TipoMensagemExtension on TipoMensagem {
  /// Extensão usada para transformar um `TipoMensagem` em um `int`.
  /// 
  /// Nessa função, você recebe o index do TipoMensagem.
  /// 
  /// Exemplo:
  /// ```dart
  /// var tipo = TipoMensagem.Alerta;
  /// var index = tipo.index; // 0
  /// ```
  int get index {
    switch (this) {
      case TipoMensagem.Alerta:
        return 0;
      case TipoMensagem.Sucesso:
        return 1;
      case TipoMensagem.Erro:
        return 2;
      case TipoMensagem.ErroCritico:
        return 3;
      case TipoMensagem.Info:
        return 4;
      case TipoMensagem.ErroPermissaoNegada:
        return 5;
      default:
        return 2;
    }
  }
}

extension TipoMensagemIntExtension on int {
  /// Extensão usada para transformar um `int` em `TipoMensagem`.
  /// 
  /// Nessa função, você recebe o `TipoMensagem` de um `index (int)`.
  /// 
  /// Exemplo:
  /// ```dart
  /// var index = 0;
  /// var tipo = index.fromIndex; // TipoMensagem.Alerta
  /// ```
  TipoMensagem get fromIndex {
    switch (this) {
      case 0:
        return TipoMensagem.Alerta;
      case 1:
        return TipoMensagem.Sucesso;
      case 2:
        return TipoMensagem.Erro;
      case 3:
        return TipoMensagem.ErroCritico;
      case 4:
        return TipoMensagem.Info;
      case 5:
        return TipoMensagem.ErroPermissaoNegada;
      default:
        return TipoMensagem.Erro;
    }
  }
}
