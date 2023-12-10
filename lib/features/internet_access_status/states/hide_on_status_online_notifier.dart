import 'dart:async';

import 'package:boycott_hub/features/internet_access_status/services/internet_access_status_service.dart';
import 'package:boycott_hub/features/internet_access_status/states/internet_access_status_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HideOnStatusOnlineNotifier extends StateNotifier<bool> {
  static final hideOnStatusOnlineStateNotifierProvider = StateNotifierProvider<HideOnStatusOnlineNotifier, bool>((ref) {
    return HideOnStatusOnlineNotifier(ref: ref);
  }, dependencies: [InternetAccessStatusNotifier.stateNotifierProvider]);

  StateNotifierProviderRef<HideOnStatusOnlineNotifier, bool> ref;
  Timer? timer;
  HideOnStatusOnlineNotifier({required this.ref}) : super(false) {
    update(ref.read(InternetAccessStatusNotifier.stateNotifierProvider));

    ref.listen(InternetAccessStatusNotifier.stateNotifierProvider, (previous, next) {
      if (previous == next) {
        return;
      }
      update(next);
    });
  }

  update(InternetAccessStatus status) {
    timer?.cancel();
    timer = null;

    if (status == InternetAccessStatus.online) {
      state = false;
      timer = Timer(Duration(seconds: 2), () {
        state = true;
        timer?.cancel();
        timer = null;
      });
      return;
    }

    state = false;
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }
}
