import 'package:boycott_hub/features/connectivity/state/connectivity_result_notifier.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class ConnectivityProviders {
  static final connectivityProvider = Provider<Connectivity>((ref) {
    throw UnimplementedError();
  });

  static final connectivityStreamProvider = StreamProvider<ConnectivityResult>(
    (ref) => throw UnimplementedError(),
    dependencies: [
      connectivityProvider,
    ],
  );

  static final connectivityResultStateProvider = StateProvider<ConnectivityResult>(
    (ref) {
      throw UnimplementedError();
    },
    dependencies: [
      connectivityStreamProvider,
    ],
  );

  static Future<List<Override>> overrideConnectivityProviders() async {
    final connectivity = Connectivity();
    final connectivityResult = await connectivity.checkConnectivity();

    return [
      connectivityProvider.overrideWith((ref) => connectivity),
      connectivityStreamProvider.overrideWith((ref) {
        return ref.read(connectivityProvider).onConnectivityChanged.distinct();
      }),
      connectivityResultStateProvider.overrideWith((ref) {
        final connectivityResultStreamValue = ref.watch(connectivityStreamProvider).value ?? connectivityResult;
        return connectivityResultStreamValue;
      }),
      ConnectivityResultNotifier.stateNotifierProvider.overrideWith((ref) {
        return ConnectivityResultNotifier(connectivity: ref.read(ConnectivityProviders.connectivityProvider), initialConnectivityResult: connectivityResult);
      }),
    ];
  }
}
