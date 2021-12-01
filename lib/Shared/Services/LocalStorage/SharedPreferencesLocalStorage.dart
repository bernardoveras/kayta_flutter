import 'package:shared_preferences/shared_preferences.dart';
import '../../Errors/ErrorState.dart';
import '../../Errors/Failure.dart';
import '../../Services/LocalStorage/ILocalStorage.dart';

class SharedPreferencesLocalStorage implements ILocalStorage {
  final SharedPreferences _sharedPreferences;
  final bool Function(String key) verifyKey;

  SharedPreferencesLocalStorage(SharedPreferences sharedPreferences, this.verifyKey) : this._sharedPreferences = sharedPreferences;

  @override
  Object? get(String key) {
    if (verifyKey(key)) {
      return _sharedPreferences.get(key);
    }

    throw ErrorState.create(MessageFailure('Key não encontrada em StoragePath.'));
  }

  @override
  Future<Map<String, dynamic>> getAll() async {
    final Set<String> keys = _sharedPreferences.getKeys();
    final Map<String, dynamic> values = Map<String, dynamic>();

    keys.forEach((key) async {
      var currentValue = _sharedPreferences.get(key);

      if (currentValue != null) values.addAll({key: currentValue});
    });

    return values;
  }

  @override
  Future<bool> add(String key, Object value) async {
    if (verifyKey(key)) {
      if (value is String)
        return await _sharedPreferences.setString(key, value);
      else if (value is List<String>)
        return await _sharedPreferences.setStringList(key, value);
      else if (value is int)
        return await _sharedPreferences.setInt(key, value);
      else if (value is double)
        return await _sharedPreferences.setDouble(key, value);
      else if (value is bool)
        return await _sharedPreferences.setBool(key, value);
      else
        return await _sharedPreferences.setString(key, value.toString());
    } else {
      throw ErrorState.create(MessageFailure('Key não encontrada em StoragePath.'));
    }
  }

  @override
  Future<bool> remove(String key) async {
    if (verifyKey(key)) {
      return await _sharedPreferences.remove(key);
    }

    throw ErrorState.create(MessageFailure('Key não encontrada em StoragePath.'));
  }

  @override
  Future<bool> removeKeys(List<String> keys) async {
    bool sucesso = false;

    for (var i = 0; i < keys.length; i++) {
      if (verifyKey(keys[i]) == false) throw ErrorState.create(MessageFailure('Key ${keys[i]} não encontrada em StoragePath.'));
    }

    for (var i = 0; i < keys.length; i++) {
      sucesso = await _sharedPreferences.remove(keys[i]);
    }

    return sucesso;
  }

  @override
  Future<bool> removeAll() async => await _sharedPreferences.clear();

  @override
  bool containsKey(String key) => _sharedPreferences.containsKey(key);
}
