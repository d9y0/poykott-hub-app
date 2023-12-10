import 'dart:async';

import 'package:boycott_hub/features/connectivity/connectivity_providers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectivityResultNotifier extends StateNotifier<ConnectivityResult> {
  static final stateNotifierProvider = StateNotifierProvider<ConnectivityResultNotifier, ConnectivityResult>(
    (ref) {
      throw UnimplementedError();
    },
    dependencies: [ConnectivityProviders.connectivityProvider],
  );
  final ConnectivityResult initialConnectivityResult;
  final Connectivity connectivity;
  final List<StreamSubscription> StreamSubscriptions = [];
  ConnectivityResultNotifier({
    required this.connectivity,
    required this.initialConnectivityResult,
  }) : super(initialConnectivityResult) {
    connectivity.onConnectivityChanged.distinct().listen((event) {
      updateState(event);
    });
  }

  updateState(ConnectivityResult connectivityResult) {
    state = connectivityResult;
  }

  @override
  void dispose() {
    for (var element in StreamSubscriptions) {
      element.cancel();
    }
    super.dispose();
  }
}
