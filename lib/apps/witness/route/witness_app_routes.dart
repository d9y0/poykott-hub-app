import 'package:auto_route/auto_route.dart';
import 'package:boycott_hub/apps/witness/ui/screens/home/home_screen.route.dart';
import 'package:boycott_hub/apps/witness/ui/screens/settings/settings_screen.route.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'witness_app_routes.gr.dart';

final witnessRouterProvider = Provider<WitnessAppRouter>((ref) => throw UnimplementedError());

@AutoRouterConfig(
  generateForDir: [
    "lib/apps/witness/",
  ],
)
class WitnessAppRouter extends _$WitnessAppRouter {
  static WitnessAppRouter? currentRouter = null;

  @override
  RouteType get defaultRouteType => const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: Witness_HomeScreenRoute.page,
          initial: true,
          path: HomeScreen.path,
        ),
        AutoRoute(
          page: Witness_SettingsScreenRoute.page,
          path: SettingsScreen.path,
        ),
      ];
}
