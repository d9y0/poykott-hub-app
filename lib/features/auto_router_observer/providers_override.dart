import 'package:boycott_hub/features/auto_router_observer/services/auto_router_observer_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutoRouterObserverProvidersOverride {
  static List<Override> override() {
    return [
      AutoRouterObserverService.provider.overrideWith(AutoRouterObserverService.providerRefFn),
    ];
  }
}
