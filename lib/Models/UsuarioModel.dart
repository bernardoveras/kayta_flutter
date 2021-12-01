import 'package:equatable/equatable.dart';
import '../Shared/Response/KaytaResponse/KaytaResponse.dart';

class UsuarioModel extends Equatable {
  const UsuarioModel({
    required this.token,
    required this.serial,
    required this.nome,
  });

  final String token;
  final String serial;
  final String nome;


  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    List claims = json["UserInfo"]["Claims"];

    return UsuarioModel(
      token: json['Token']['AccessToken'] as String,
      serial: _obterSerial(claims),
      nome: _obterNome(claims),
    );
  }

  static String _obterNome(List claims) {
    return claims.where((c) => c["Key"].contains("http://schemas.vvssistemas.com.br/ws/identity/claims/usuario/nome")).single["Value"];
  }

  static String _obterSerial(List claims) {
    var id = claims.where((c) => c["Key"].contains("grupoempresa/ids")).single['Value'];
    var serial = claims.where((c) => c["Key"].contains("grupoempresa/$id/serial")).single["Value"];

    return serial ?? '';
  }

  static KaytaResponse<UsuarioModel> toKaytaResponse(Map<String, dynamic> json) {
    return KaytaResponse<UsuarioModel>.fromJson(json, json['HasValue'] == true ? UsuarioModel.fromJson(json['Value']) : null);
  }

  @override
  List<Object?> get props => [nome, token, serial];
}
