import 'package:boycott_hub/apps/boycottisraelitech/features/companies/states/companies_api_provider.dart';
import 'package:boycott_hub/apps/boycottisraelitech/features/dio/services/dio_service.dart';
import 'package:boycott_hub/apps/boycottisraelitech/route/app_routes.dart';
import 'package:boycott_hub/apps/boycottisraelitech/ui/theme/app_theme.dart';
import 'package:boycott_hub/features/app_prefix/app_prefix_provider.dart';
import 'package:boycott_hub/features/auto_router_observer/providers_override.dart';

import 'package:boycott_hub/features/auto_router_observer/services/auto_router_observer_service.dart';
import 'package:boycott_hub/features/shared_states/search_state/search_state_provider.dart';
import 'package:boycott_hub/features/theme_mode/theme_mode_providers.dart';
import 'package:boycott_hub/ui/widgets/internent_connectation_status_widget.dart';
import 'package:boycott_hub/utile/custom_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoycottIsraeliTechApp extends ConsumerWidget {
  static Future<List<Override>> overridesRiverpod() async {
    return [
      appPrefix.overrideWith((ref) => 'BoycottIsraeliTechAppWrapper_'),
      ...AutoRouterObserverProvidersOverride.override(),
      DioService.provider.overrideWith(await DioService.providerRefFn()),
      searchStateProvider.overrideWith((ref) => ''),
      ...CompaniesStateProviders.getOverrides(),
    ];
  }

  const BoycottIsraeliTechApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifier);
    return MaterialApp.router(
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Expanded(child: child!),
              const InternentConnectationStatusWidget(),
            ],
          ),
        );
      },
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehavior(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routeInformationParser: boycottIsraeliTechRouter.defaultRouteParser(),
      routerDelegate: boycottIsraeliTechRouter.delegate(
        navigatorObservers: () => [ref.read(AutoRouterObserverService.provider)],
      ),
    );
  }
}
