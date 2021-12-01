import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:kayta_flutter/Models/ConfiguracaoInicialModel.dart';
import 'package:kayta_flutter/ServiceAgents/ConfiguracaoInicial/ConfiguracaoInicialServiceAgent.dart';
import 'package:kayta_flutter/ServiceAgents/ConfiguracaoInicial/IConfiguracaoInicialServiceAgent.dart';
import 'package:kayta_flutter/Shared/Errors/ErrorState.dart';
import 'package:kayta_flutter/Shared/Response/KaytaResponse/KaytaResponse.dart';
import 'package:mockito/mockito.dart';
import '../../Mocks/JsonReader.dart';
import '../Login/LoginServiceAgent_test.mocks.dart';

main() {
  late IConfiguracaoInicialServiceAgent serviceAgent;
  late MockIHttpService httpService;
  late ConfiguracaoInicialModel configuracaoInicial;

  mockSuccess() => when(httpService.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer(
        (_) async => Response(jsonReader('ConfiguracaoInicial/Success.json'), 200),
      );

  mockError([Exception? exception]) => when(httpService.get(
        any,
        headers: anyNamed('headers'),
      )).thenThrow(exception ?? SocketException('Connection refused'));

  setUp(() {
    httpService = MockIHttpService();

    serviceAgent = ConfiguracaoInicialServiceAgent(httpService);
    configuracaoInicial = ConfiguracaoInicialModel(enderecoDoServidor: '0.0.0.0', ambienteDoServidor: 'Local', portaDoServidor: '8888');
  });

  test('Deve chamar HttpClient com os valores corretos', () async {
    mockSuccess();

    await serviceAgent.verificarConexao(configuracaoInicial);

    verify(
      httpService.get('http://${configuracaoInicial.enderecoDoServidor}:${configuracaoInicial.portaDoServidor}/keepalive'),
    ).called(1);
  });

  test('Deve retornar um Result<bool> caso retornar sucesso', () async {
    mockSuccess();

    final KaytaResponse<bool> result = await serviceAgent.verificarConexao(configuracaoInicial);

    expect(result.value, true);
    expect(result.hasError, false);
    expect(result.ok, true);
  });

  test('Deve retornar um Result com erro caso der erro', () async {
    mockError();

    var future = serviceAgent.verificarConexao(configuracaoInicial);

    expect(future, throwsA(TypeMatcher<ErrorState>()));
  });
}
