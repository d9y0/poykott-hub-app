import 'dart:async';
import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:boycott_hub/features/auto_router_observer/models/route_stack_iteem_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutoRouterObserverService extends AutoRouterObserver {
  static AutoRouterObserverService Function(ProviderRef<AutoRouterObserverService>) providerRefFn = (ref) {
    final service = AutoRouterObserverService();

    ref.onDispose(() {
      service.dispose();
    });
    return service;
  };
  static Provider<AutoRouterObserverService> provider = Provider<AutoRouterObserverService>(providerRefFn);

  final StreamController<RouteStackIteemModel<dynamic>> streamController = StreamController<RouteStackIteemModel<dynamic>>.broadcast();
  final navStack = <RouteStackIteemModel<dynamic>>[];
  RouteStackIteemModel currentRouteStackIteemModel = const RouteStackIteemModel(name: "", args: null);

  void _addToStack(Route route) {
    if (streamController.isClosed) {
      return;
    }
    navStack.add(RouteStackIteemModel.fromRoute(route));
    currentRouteStackIteemModel = navStack.last;
    log("---<{${currentRouteStackIteemModel.name}}>---");
    streamController.sink.add(currentRouteStackIteemModel);
  }

  RouteStackIteemModel? _removeLastFromStack() {
    if (streamController.isClosed) {
      return null;
    }
    final c = navStack.removeLast();
    currentRouteStackIteemModel = navStack.last;
    log("---<{${currentRouteStackIteemModel.name}}>---");
    streamController.sink.add(currentRouteStackIteemModel);
    return c;
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute != null) {
      _removeLastFromStack();
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _addToStack(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (previousRoute != null) {
      _removeLastFromStack();
    }
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (oldRoute != null) {
      _removeLastFromStack();
    }
    if (newRoute != null) {
      _addToStack(newRoute);
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    // TODO: implement didStartUserGesture
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    // TODO: implement didStopUserGesture
    super.didStopUserGesture();
  }

  void dispose() {
    streamController.close();
  }
}
