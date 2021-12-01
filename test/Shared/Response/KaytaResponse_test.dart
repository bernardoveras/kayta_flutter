import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:kayta_flutter/Models/UsuarioModel.dart';
import 'package:kayta_flutter/Shared/Response/BaseResponse/BaseResponse.dart';
import 'package:kayta_flutter/Shared/Response/BaseResponse/HttpResponse.dart';
import 'package:kayta_flutter/Shared/Response/KaytaResponse/IKaytaResponse.dart';
import 'package:kayta_flutter/Shared/Response/Mensagem.dart';
import '../../Mocks/JsonReader.dart';

main() {
  late IKaytaResponse response;

  test('KaytaResponse test with value', () {
    var body = jsonDecode(jsonReader('KaytaResponse/KaytaResponseWithUsuarioModel.json'));
    response = UsuarioModel.toKaytaResponse(body);

    expect(response.value, isA<UsuarioModel>());
    expect(response.mensagens, null);
    expect(response.ok, true);
    expect(response.hasError, false);
    expect(response.hasValue, true);
  });

  test('KaytaResponse test with error', () {
    var body = jsonDecode(jsonReader('KaytaResponse/KaytaResponseWithError.json'));
    response = UsuarioModel.toKaytaResponse(body);

    expect(response.value, null);
    expect(response.mensagens, isA<List<Mensagem>>());
    expect(response.ok, false);
    expect(response.hasError, true);
    expect(response.hasValue, false);
  });

  test('KaytaResponse test with BaseResponse', () {
    var body = jsonReader('KaytaResponse/KaytaResponseWithUsuarioModel.json');
    Response httpResponse = Response(body, 200);
    IBaseResponse baseResponse = HttpResponse.fromResponse(httpResponse);

    response = UsuarioModel.toKaytaResponse(baseResponse.body);

    expect(response.value, isA<UsuarioModel>());
    expect(response.mensagens, null);
    expect(response.ok, true);
    expect(response.hasError, false);
    expect(response.hasValue, true);
  });
}
