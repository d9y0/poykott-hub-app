import 'package:auto_route/auto_route.dart';
import 'package:boycott_hub/apps/boycottisraelitech/features/companies/models/company_res_model.dart';
import 'package:boycott_hub/apps/boycottisraelitech/ui/bottom_sheets/search_filters/search_filters.route.dart';
import 'package:boycott_hub/apps/boycottisraelitech/ui/screens/details/details_screen.route.dart';
import 'package:boycott_hub/apps/boycottisraelitech/ui/screens/home/home_screen.route.dart';
import 'package:boycott_hub/apps/boycottisraelitech/ui/screens/settings/settings_screen.route.dart';
import 'package:boycott_hub/apps/boycottisraelitech/ui/screens/splash/splash_screen.route.dart';
import 'package:flutter/material.dart';
//import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modalBottomSheet;

part 'app_routes.gr.dart';

Route<T> modalSheetBuilder<T>(BuildContext context, Widget child, AutoRoutePage<T> settings) {
  return ModalBottomSheetRoute(
    settings: settings,
    builder: (context) => child,
    isScrollControlled: false,
    showDragHandle: true,
    useSafeArea: true,
    //constraints: BoxConstraints.tightFor(height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height / 5)),
  );

  //expanded: true,
}

final boycottIsraeliTechRouter = AppRouter();

@AutoRouterConfig(
  generateForDir: [
    "lib/apps/boycottisraelitech/",
  ],
)
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: BoycottIsraeliTech_SplashScreenRoute.page,
          initial: true,
          path: SplashScreen.path,
        ),
        AutoRoute(
          page: BoycottIsraeliTech_HomeScreenRoute.page,
          path: HomeScreen.path,
        ),
        AutoRoute(
          page: BoycottIsraeliTech_DetailsScreenRoute.page,
          path: DetailsScreen.path,
        ),
        AutoRoute(
          page: BoycottIsraeliTech_SettingsScreenRoute.page,
          path: SettingsScreen.path,
        ),

        CustomRoute(
          page: BoycottIsraeliTech_SearchFiltersBottomSheetsRoute.page,
          path: SearchFilter.path,
          customRouteBuilder: modalSheetBuilder,
        ),

        //SplashScreenRoute
      ];
}
