import 'package:auto_route/auto_route.dart';
import 'package:boycott_hub/app/ui/screens/apps/apps_screen.route.dart';
import 'package:boycott_hub/app/ui/screens/bdnaash_lancher/bdnaash_lancher_screen.route.dart';
import 'package:boycott_hub/app/ui/screens/boycott_israeli_tech_lancher/boycott_israeli_tech_lancher.route.dart';
import 'package:boycott_hub/app/ui/screens/settings/settings_screen.route.dart';
import 'package:boycott_hub/app/ui/screens/splash/splash_screen.route.dart';

part 'app_route.gr.dart';

final boycottAllInOneAppRouter = AppRouter();

@AutoRouterConfig(
  generateForDir: [
    "lib/app/",
  ],
)
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashScreenRoute.page,
          initial: true,
          path: SplashScreen.path,
        ),
        AutoRoute(
          page: AppsScreenRoute.page,
          path: AppsScreen.path,
        ),
        AutoRoute(
          page: SettingsScreenRoute.page,
          path: SettingsScreen.path,
        ),
        AutoRoute(
          page: BoycottIsraeliTechLancherScreenRoute.page,
          path: BoycottIsraeliTechLancherScreen.path,
        ),
        AutoRoute(
          page: BdnaashLancherScreenRoute.page,
          path: BdnaashLancherScreen.path,
        ),

        //SplashScreenRoute
      ];
}
