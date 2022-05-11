import 'package:connectivity/connectivity.dart';
import 'INetworkService.dart';

class NetworkService implements INetworkService {
  const NetworkService(Connectivity connectivity) : _connectivity = connectivity;

  final Connectivity _connectivity;

  @override
  Future<bool> isOnline() async {
    var connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) return false;

    return true;
  }

  @override
  Future<bool> isOffline() async => !await isOnline();
}