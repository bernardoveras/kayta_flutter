import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:kayta_flutter/Models/UsuarioModel.dart';
import 'package:kayta_flutter/Shared/Services/HttpService/HttpService.dart';
import 'package:kayta_flutter/Shared/Services/HttpService/IHttpService.dart';
import 'package:kayta_flutter/Shared/Services/NetworkService/NetworkService.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../Mocks/JsonReader.dart';
import 'HttpService_test.mocks.dart';

@GenerateMocks([Client, NetworkService])
main() {
  late IHttpService httpService;
  late MockClient client;
  late MockNetworkService networkService;

  setUp(() {
    client = MockClient();
    networkService = MockNetworkService();

    httpService = HttpService(
      client,
      networkService,
      considerarInternet: false,
      baseUrl: 'http://10.0.2.2:8080',
    );
  });

  void mockSuccess(String json, int statusCode) {
    when(client.get(any, headers: anyNamed("headers"))).thenAnswer(
      (_) async => Response(jsonReader(json), statusCode),
    );
  }

  group('Get', () {
    test('Deve retornar um KaytaResponse com erro caso retornar statuscode 200', () async {
      mockSuccess('KaytaResponse/KaytaResponseWithError.json', 200);

      final result = await httpService.get('rota');

      expect(result.statusCode, 200);
    });

    test('Deve retornar um UsuarioModel caso retornar StatusCode 200', () async {
      mockSuccess('KaytaResponse/KaytaResponseWithUsuarioModel.json', 200);

      final result = await httpService.get('rota');

      var body = jsonDecode(result.body);
      var usuario = UsuarioModel.fromJson(body['Value']);

      expect(result.statusCode, 200);
      expect(usuario, isA<UsuarioModel>());
    });
  });
}
