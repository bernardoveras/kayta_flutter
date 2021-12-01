import 'package:flutter_test/flutter_test.dart';
import 'package:kayta_flutter/Shared/Errors/ErrorState.dart';
import 'package:kayta_flutter/Shared/Services/LocalStorage/ILocalStorage.dart';
import 'package:kayta_flutter/Shared/Services/LocalStorage/SharedPreferencesLocalStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _StoragePath {
  static const ENDERECO = 'endereco';
  static const PORTA = 'porta';
  static const AMBIENTE = 'ambiente';
}

void main() {
  late SharedPreferences sharedPreferences;
  late ILocalStorage localStorage;

  bool mock = true;

  final String enderecoDoServidor = '192.168.1.110';
  final String portaDoServidor = '8888';
  final String ambienteDoServidor = 'Local';

  final Map<String, Object> storageMap = {
    _StoragePath.ENDERECO: enderecoDoServidor,
    _StoragePath.PORTA: portaDoServidor,
    _StoragePath.AMBIENTE: ambienteDoServidor,
  };

  void mockValues(Map<String, Object> values) => SharedPreferences.setMockInitialValues(values);

  bool verifyContains(String key) {
    if (key == _StoragePath.ENDERECO) return true;
    if (key == _StoragePath.PORTA) return true;
    if (key == _StoragePath.AMBIENTE) return true;
    return false;
  }

  setUp(() async {
    if (mock == true) mockValues(storageMap);
    sharedPreferences = await SharedPreferences.getInstance();
    localStorage = SharedPreferencesLocalStorage(sharedPreferences, verifyContains);
  });

  group('Get and GetAll', () {
    test('Deve retornar o endereço do servidor caso for sucesso', () {
      final result = localStorage.get(_StoragePath.ENDERECO);

      expect(result, enderecoDoServidor);
    });

    test('Deve retornar todos os registros do local storage', () async {
      final result = await localStorage.getAll();

      expect(result, storageMap);
    });
  });

  group('Remove, RemoveKeys and RemoveAll', () {
    test('Deve retornar true caso remover com sucesso', () async {
      final result = await localStorage.remove(_StoragePath.ENDERECO);
      final storage = await localStorage.getAll();

      expect(result, true);
      expect(storage.containsKey(_StoragePath.ENDERECO), false);
    });

    test('Deve retornar true caso remover os 2 registros com sucesso', () async {
      final result = await localStorage.removeKeys([_StoragePath.ENDERECO, _StoragePath.AMBIENTE]);
      final storage = await localStorage.getAll();

      expect(storage.containsKey(_StoragePath.ENDERECO), false);
      expect(storage.containsKey(_StoragePath.AMBIENTE), false);
      expect(result, true);
    });

    test('Deve retornar true caso remover todos os registros com sucesso', () async {
      final result = await localStorage.removeAll();
      final storage = await localStorage.getAll();

      expect(result, true);
      expect(storage.length, 0);
    });
  });

  group('Add', () {
    setUpAll(() => mock = false);
    test('Deve retornar true caso adicionar o registro', () async {
      final result = await Future.wait([
        localStorage.add(_StoragePath.ENDERECO, enderecoDoServidor),
        localStorage.add(_StoragePath.PORTA, portaDoServidor),
        localStorage.add(_StoragePath.AMBIENTE, ambienteDoServidor)
      ]);

      final bool adicionou = localStorage.get(_StoragePath.ENDERECO) == enderecoDoServidor;

      expect(adicionou, true);
      expect(result.where((e) => e == true).length, 3);
    });
  });

  group('ContainsKey', () {
    test('Deve retornar true caso conter a key informada', () {
      final result = localStorage.containsKey(_StoragePath.AMBIENTE);

      expect(result, true);
    });

    test('Deve retornar false caso não conter a key informada', () {
      final result = localStorage.containsKey('teste');

      expect(result, false);
    });
  });

  test('Deve retornar um erro caso a Key não existir em StoragePath', () async {
    final add = localStorage.add;
    final get = localStorage.get;
    final remove = localStorage.remove;
    final removeKeys = localStorage.removeKeys;

    expect(() => add('keyinexistente', 'teste'), throwsA(TypeMatcher<ErrorState>()));
    expect(() => get('keyinexistente'), throwsA(TypeMatcher<ErrorState>()));
    expect(() => remove('keyinexistente'), throwsA(TypeMatcher<ErrorState>()));
    expect(() => removeKeys([_StoragePath.AMBIENTE, 'keyinexistente']), throwsA(TypeMatcher<ErrorState>()));
  });
}
