import '../Enums/TipoMensagem.dart';

class Mensagem {
  final TipoMensagem tipo;
  final String texto;

  Mensagem({required this.tipo, required this.texto});

  factory Mensagem.fromJson(Map<String, dynamic> json) {
    return Mensagem(
      texto: json['Texto'],
      tipo: (json['Tipo'] as int).fromIndex,
    );
  }
}