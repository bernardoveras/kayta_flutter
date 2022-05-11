import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kayta_flutter/Shared/Services/NetworkService/INetworkService.dart';
import 'package:kayta_flutter/Shared/Services/NetworkService/NetworkService.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'NetworkService_test.mocks.dart';

@GenerateMocks([Connectivity])

main() {
  late INetworkService networkService;
  late Connectivity connectivity;

  setUp(() {
    connectivity = MockConnectivity();
    networkService = NetworkService(connectivity);
  });

  void mockNetwork({required bool online}) {
    var result = online ? ConnectivityResult.mobile : ConnectivityResult.none;
    when(connectivity.checkConnectivity()).thenAnswer((_) async => result);
  }

  test("Test Online", () async {
    mockNetwork(online: true);
    expect(await networkService.isOnline(), true);

    mockNetwork(online: false);
    expect(await networkService.isOnline(), false);
  });

  test("Test Offline", () async {
    mockNetwork(online: false);
    expect(await networkService.isOffline(), true);

    mockNetwork(online: true);
    expect(await networkService.isOffline(), false);
  });
}
