import 'package:boycott_hub/app/routes/app_route.dart';

import 'package:boycott_hub/app/ui/theme/app_theme.dart';
import 'package:boycott_hub/features/auto_router_observer/services/auto_router_observer_service.dart';
import 'package:boycott_hub/features/theme_mode/theme_mode_providers.dart';

import 'package:boycott_hub/ui/widgets/internent_connectation_status_widget.dart';

import 'package:boycott_hub/utile/custom_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoycottAllInOne extends ConsumerWidget {
  const BoycottAllInOne({super.key});

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
      routeInformationParser: boycottAllInOneAppRouter.defaultRouteParser(),
      routerDelegate: boycottAllInOneAppRouter.delegate(
        navigatorObservers: () => [ref.read(AutoRouterObserverService.provider)],
      ),
    );
  }
}
