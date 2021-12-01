abstract class ILocalStorage {
  /// Utilize esse método para obter um valor do LocalStorage.
  /// ```dart
  /// localStorage.get(StoragePath.KEY);
  /// ```
  Object? get(String key);

  /// Utilize esse método para obter todos os valores do LocalStorage.
  /// ```dart
  /// localStorage.getAll();
  /// ```
  Future<Map<String, dynamic>> getAll();

  /// Utilize esse método para adicionar um valor no LocalStorage.
  /// ```dart
  /// localStorage.add(StoragePath.KEY, "value");
  /// ```
  Future<bool> add(String key, Object value);

  /// Utilize esse método para remover um valor do LocalStorage.
  /// ```dart
  /// localStorage.remove(StoragePath.KEY);
  /// ```
  Future<bool> remove(String key);

  /// Utilize esse método para remover vários valores do LocalStorage.
  /// ```dart
  /// localStorage.removeKeys([StoragePath.KEY, StoragePath.KEY_TWO]);
  /// ```
  Future<bool> removeKeys(List<String> keys);

  /// Utilize esse método para remover todos os valores do LocalStorage.
  /// `Obs: Remove definitivamente todos os dados, cuidado!`
  /// ```dart
  /// localStorage.removeAll();
  /// ```
  Future<bool> removeAll();

  /// Utilize esse método para verificar se existe uma Key no LocalStorage.
  /// ```dart
  /// localStorage.containsKey(StoragePath.KEY);
  /// ```
  bool containsKey(String key);
}
