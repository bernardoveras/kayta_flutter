import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:kayta_flutter/Models/UsuarioModel.dart';
import 'package:kayta_flutter/ServiceAgents/Login/ILoginServiceAgent.dart';
import 'package:kayta_flutter/ServiceAgents/Login/LoginServiceAgent.dart';
import 'package:kayta_flutter/Shared/Response/KaytaResponse/KaytaResponse.dart';
import 'package:kayta_flutter/Shared/Services/HttpService/IHttpService.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../Mocks/JsonReader.dart';
import 'LoginServiceAgent_test.mocks.dart';

@GenerateMocks([IHttpService])
main() {
  late ILoginServiceAgent serviceAgent;
  late MockIHttpService httpService;

  final String usuario = 'admin';
  final String senha = 'admin';

  mockSuccess([String json = 'LoginSuccess', int statusCode = 200]) => when(httpService.post(
        any,
        body: anyNamed('body'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => Response(jsonReader('Login/$json.json'), statusCode));

  setUp(() {
    httpService = MockIHttpService();
    serviceAgent = LoginServiceAgent(httpService: httpService, ambienteDoServidor: 'Local');

    mockSuccess();
  });

  test('Deve chamar HttpClient com os valores corretos', () async {
    var str = usuario + ":" + senha;
    var bytes = utf8.encode(str);
    var basic64 = "Basic " + base64.encode(bytes);

    await serviceAgent.logar(usuario, senha);

    verify(
      httpService.post(
        'seguranca/controleacesso/usuarios/autenticar',
        body: jsonEncode({'login': usuario, 'senha': senha}),
        headers: {
          'Authorization': basic64,
          'X-Ambiente': 'Local',
        },
      ),
    ).called(1);
  });

  test('Deve retornar um Result<UsuarioModel> caso retornar sucesso', () async {
    final KaytaResponse<UsuarioModel> result = await serviceAgent.logar(usuario, senha);

    expect(result.value, isA<UsuarioModel>());
    expect(result.hasError, false);
    expect(result.ok, true);
  });

  test('Deve retornar um Result com erro caso der erro', () async {
    mockSuccess('LoginFailed', 400);

    final KaytaResponse<UsuarioModel> result = await serviceAgent.logar(usuario, senha);

    expect(result.value, null);
    expect(result.hasError, true);
    expect(result.ok, false);
  });
}
