import 'package:boycott_hub/features/auto_router_observer/models/route_stack_iteem_model.dart';
import 'package:boycott_hub/features/auto_router_observer/services/auto_router_observer_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentRouteStreamProvider = StreamProvider<RouteStackIteemModel>((ref) async* {
  yield* ref.read(AutoRouterObserverService.provider).streamController.stream.distinct();

  //return ref.read(AutoRouterObserverService.provider).streamController.stream.distinct();
}, dependencies: [AutoRouterObserverService.provider]);
