import 'package:boycott_hub/app/ui/theme/app_theme.dart';
import 'package:boycott_hub/apps/witness/route/witness_app_routes.dart';

import 'package:boycott_hub/features/app_prefix/app_prefix_provider.dart';
import 'package:boycott_hub/features/auto_router_observer/providers_override.dart';

import 'package:boycott_hub/features/auto_router_observer/services/auto_router_observer_service.dart';
import 'package:boycott_hub/features/dio/dio_provider.dart';
import 'package:boycott_hub/features/shared_states/search_state/search_state_provider.dart';
import 'package:boycott_hub/features/theme_mode/theme_mode_providers.dart';
import 'package:boycott_hub/ui/widgets/internent_connectation_status_widget.dart';
import 'package:boycott_hub/utile/custom_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WitnessApp extends ConsumerWidget {
  const WitnessApp({super.key});

  static Future<List<Override>> overridesRiverpod() async {
    return [
      appPrefix.overrideWith((ref) => 'witness_'),
      ...AutoRouterObserverProvidersOverride.override(),
      searchStateProvider.overrideWith((ref) => ''),
      ...(await DioProvider.override()),
      witnessRouterProvider.overrideWith((ref) {
        final appRouter = WitnessAppRouter();
        WitnessAppRouter.currentRouter = appRouter;
        ref.onDispose(() {
          WitnessAppRouter.currentRouter?.dispose();
          WitnessAppRouter.currentRouter = null;
        });
        return appRouter;
      }),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifier);
    return MaterialApp.router(
      builder: (context, child) {
        return Column(
          children: [
            Expanded(child: child!),
            const InternentConnectationStatusWidget(),
          ],
        );
      },
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehavior(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routeInformationParser: ref.read(witnessRouterProvider).defaultRouteParser(),
      routerDelegate: ref.read(witnessRouterProvider).delegate(
            navigatorObservers: () => [ref.read(AutoRouterObserverService.provider)],
          ),
    );
  }
}
