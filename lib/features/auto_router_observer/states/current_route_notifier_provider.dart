import 'dart:async';
import 'package:boycott_hub/features/auto_router_observer/models/route_stack_iteem_model.dart';
import 'package:boycott_hub/features/auto_router_observer/services/auto_router_observer_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentRouteNotifierProvider extends StateNotifier<RouteStackIteemModel> {
  static final notifierProvider = StateNotifierProvider<CurrentRouteNotifierProvider, RouteStackIteemModel>(
    (ref) {
      return CurrentRouteNotifierProvider(initialRouteStackIteemModel: ref.read(AutoRouterObserverService.provider).currentRouteStackIteemModel, ref: ref);
    },
    dependencies: [AutoRouterObserverService.provider],
  );
  final StateNotifierProviderRef<CurrentRouteNotifierProvider, RouteStackIteemModel> ref;
  final RouteStackIteemModel initialRouteStackIteemModel;
  final List<StreamSubscription> subscriptions = [];
  CurrentRouteNotifierProvider({required this.ref, required this.initialRouteStackIteemModel}) : super(initialRouteStackIteemModel) {
    subscriptions.add(ref.read(AutoRouterObserverService.provider).streamController.stream.distinct().listen((event) {
      state = event;
    }));
  }

  @override
  void dispose() {
    for (var subscription in subscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }
}
