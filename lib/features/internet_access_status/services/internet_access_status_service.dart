import 'dart:async';
import 'dart:developer';

import 'package:boycott_hub/features/connectivity/state/connectivity_result_notifier.dart';
import 'package:boycott_hub/features/internet_access_status/repositories/internet_access_status_repository.dart';
import 'package:boycott_hub/utile/custom_cancelable_operation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum InternetAccessStatus {
  online,
  offline,
  loading,
  //none,
}

class InternetAccessStatusService {
  static final provider = Provider<InternetAccessStatusService>(
    (ref) {
      final initialConnectivityResult = ref.read(ConnectivityResultNotifier.stateNotifierProvider);
      final internetAccessStatusRepository = ref.read(InternetAccessStatusRepository.provider);
      final internetAccessStatusService = InternetAccessStatusService(internetAccessStatusRepository: internetAccessStatusRepository, initialConnectivityResult: initialConnectivityResult);

      final providerSubscription = ref.listen(ConnectivityResultNotifier.stateNotifierProvider, (previous, next) {
        internetAccessStatusService.onUpdateConnectivityResultState(previous, next);
      });

      ref.onDispose(() {
        providerSubscription.close();
        internetAccessStatusService.timer?.cancel();
        internetAccessStatusService.checkInternetAccessOperation.cancelableOperation?.cancel();
        internetAccessStatusService.streamController.close();
      });

      //final connectivityResult = ref.read(connectivityStreamProvider).value;
      return internetAccessStatusService;
    },
    dependencies: [InternetAccessStatusRepository.provider, ConnectivityResultNotifier.stateNotifierProvider],
  );

  static final internetAccessStatusStreamProvider = StreamProvider<InternetAccessStatus>(
    (ref) => ref.read(InternetAccessStatusService.provider).streamController.stream.distinct(),
    dependencies: [
      InternetAccessStatusService.provider,
    ],
  );

  Timer? timer;

  /*= Timer(Duration(seconds: 15), () {
    
  });*/
  late CustomCancelableOperation<Response<void>?> checkInternetAccessOperation = CustomCancelableOperation(
    _checkInternetAccess,
    onCancel: (cancelableCompleter) {
      log("onCancel -- loading");
      currentStatus = InternetAccessStatus.loading;
      timer?.cancel();
      timer = null;
    },
    onStartOperation: () {
      log("onStartOperation -- loading");
      currentStatus = InternetAccessStatus.loading;
      timer?.cancel();
      timer = null;
    },
    onValue: (res, cancelableCompleter) {
      timer?.cancel();
      timer = null;

      if (res?.statusCode == 204) {
        log("onValue statusCode == 204 -- online");
        currentStatus = InternetAccessStatus.online;
      } else {
        log("onValue statusCode == error -- offline");
        currentStatus = InternetAccessStatus.offline;

        if (_currentConnectivityResult != ConnectivityResult.none) {
          timer = Timer(const Duration(seconds: 15), () {
            checkInternetAccess();
          });
        }
      }
    },
    onError: (e, stackTrace, cancelableCompleter) {
      timer?.cancel();
      timer = null;
      if (_currentConnectivityResult != ConnectivityResult.none) {
        timer = Timer(const Duration(seconds: 15), () {
          checkInternetAccess();
        });
      }
      log("onError -- offline");
      currentStatus = InternetAccessStatus.offline;
    },
  );
  final ConnectivityResult initialConnectivityResult;
  late ConnectivityResult _currentConnectivityResult = initialConnectivityResult;

  InternetAccessStatus _currentStatus = InternetAccessStatus.offline;
  set currentStatus(InternetAccessStatus val) {
    _currentStatus = val;
    streamController.sink.add(val);
  }

  InternetAccessStatus get currentStatus {
    return _currentStatus;
  }

  final StreamController<InternetAccessStatus> streamController = StreamController.broadcast(sync: true);
  final InternetAccessStatusRepository internetAccessStatusRepository;

  InternetAccessStatusService({
    required this.internetAccessStatusRepository,
    required this.initialConnectivityResult,
  }) {
    onUpdateConnectivityResultState(initialConnectivityResult, initialConnectivityResult);
  }

  Future<Response<void>?> _checkInternetAccess({Map<String, dynamic>? args}) async {
    try {
      final res = await internetAccessStatusRepository.call();

      return res;
    } on DioException catch (e) {
      return e.response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> checkInternetAccess() async {
    try {
      if (_currentConnectivityResult == ConnectivityResult.none) return;

      await checkInternetAccessOperation.load();
    } catch (e) {}
  }

  Future<void> onUpdateConnectivityResultState(ConnectivityResult? previous, ConnectivityResult next) async {
    _currentConnectivityResult = next;
    if (next == ConnectivityResult.none) {
      log("onUpdate -- ConnectivityResult.none --- InternetAccessStatus.offline");
      await checkInternetAccessOperation.cancelableOperation?.cancel();
      timer?.cancel();
      timer = null;
      currentStatus = InternetAccessStatus.offline;
    } else {
      await checkInternetAccessOperation.cancelableOperation?.cancel();
      timer?.cancel();
      timer = null;
      await checkInternetAccess();
    }
  }
}
