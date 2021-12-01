import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:kayta_flutter/Shared/Response/KaytaVoidResponse/KaytaVoidResponse.dart';
import 'package:kayta_flutter/Shared/Response/Mensagem.dart';
import '../../Mocks/JsonReader.dart';

main() {
  late KaytaVoidResponse response;

  test('KaytaResponse test without value', () {
    response = KaytaVoidResponse.fromJson(jsonDecode(jsonReader('KaytaResponse/KaytaResponseEmpty.json')));

    expect(response.mensagens, isA<List<Mensagem>>());
    expect(response.ok, true);
    expect(response.hasError, false);
    expect(response.hasValue, false);
  });
}
