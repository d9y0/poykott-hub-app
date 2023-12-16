import 'package:auto_route/auto_route.dart';
import 'package:boycott_hub/apps/bdnaash/ui/dialogs/not_support_zion/not_support_zion_dialog.route.dart';
import 'package:boycott_hub/apps/bdnaash/ui/dialogs/support_zion/support_zion_dialog.route.dart';
import 'package:boycott_hub/apps/bdnaash/ui/screens/home/home_screen.route.dart';
import 'package:boycott_hub/apps/bdnaash/ui/screens/settings/settings_screen.route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'bdnaash_app_routes.gr.dart';

//final bdnaashRouter = BdnaashAppRouter();
Route<T> dialogBuilder<T>(BuildContext context, Widget child, AutoRoutePage<T> settings) {
  return DialogRoute(
    context: context,
    builder: (context) => child,
    settings: settings,
    //barrierColor: Colors.transparent,
    barrierDismissible: true,
  );

  //expanded: true,
}

final bdnaashRouterProvider = Provider<BdnaashAppRouter>((ref) => throw UnimplementedError());

@AutoRouterConfig(
  generateForDir: [
    "lib/apps/bdnaash/",
  ],
)
class BdnaashAppRouter extends _$BdnaashAppRouter {
  static BdnaashAppRouter? currentRouter = null;

  @override
  RouteType get defaultRouteType => const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: Bdnaash_HomeScreenRoute.page,
          initial: true,
          path: HomeScreen.path,
        ),
        AutoRoute(
          page: Bdnaash_SettingsScreenRoute.page,
          path: SettingsScreen.path,
        ),
        CustomRoute(
          page: Bdnaash_SupportZionDialogRoute.page,
          path: SupportZionDialog.path,
          customRouteBuilder: dialogBuilder,
          fullscreenDialog: true,
        ),
        CustomRoute(
          page: Bdnaash_NotSupportZionDialogRoute.page,
          path: NotSupportZionDialog.path,
          customRouteBuilder: dialogBuilder,
          fullscreenDialog: true,
        ),

        /**
         *  CustomRoute(
          page: BoycottIsraeliTech_SearchFiltersBottomSheetsRoute.page,
          path: SearchFilter.path,
          customRouteBuilder: modalSheetBuilder,
        ),
         */
      ];
}
