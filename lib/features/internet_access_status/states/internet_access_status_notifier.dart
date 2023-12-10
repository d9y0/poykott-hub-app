import 'dart:async';

import 'package:boycott_hub/features/internet_access_status/services/internet_access_status_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InternetAccessStatusNotifier extends StateNotifier<InternetAccessStatus> {
  static final stateNotifierProvider = StateNotifierProvider<InternetAccessStatusNotifier, InternetAccessStatus>(
    (ref) {
      final internetAccessStatusNotifier = InternetAccessStatusNotifier(
        internetAccessStatusService: ref.read(InternetAccessStatusService.provider),
      );
      ref.read(InternetAccessStatusService.provider).streamController.stream.distinct().listen((event) {});
      return internetAccessStatusNotifier;
    },
    dependencies: [InternetAccessStatusService.provider],
  );

  final InternetAccessStatusService internetAccessStatusService;
  final List<StreamSubscription> streamSubscriptionList = [];
  InternetAccessStatusNotifier({required this.internetAccessStatusService}) : super(internetAccessStatusService.currentStatus) {
    streamSubscriptionList.add(internetAccessStatusService.streamController.stream.distinct().listen((event) {
      state = event;
    }));
  }

  void checkInternetAccess() {
    internetAccessStatusService.checkInternetAccess();
  }

  @override
  void dispose() {
    for (var element in streamSubscriptionList) {
      element.cancel();
    }

    super.dispose();
  }
}
