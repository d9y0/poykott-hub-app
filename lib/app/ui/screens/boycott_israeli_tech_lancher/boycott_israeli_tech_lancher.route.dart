import 'package:auto_route/auto_route.dart';
import 'package:boycott_hub/apps/boycottisraelitech/main/boycott_israeli_tech_app.dart';
import 'package:boycott_hub/apps/boycottisraelitech/route/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage(
  name: BoycottIsraeliTechLancherScreen.name,
)
class BoycottIsraeliTechLancherScreen extends StatelessWidget {
  static const name = "BoycottIsraeliTechLancherScreenRoute";
  static const path = "/boycottIsraeliTechLancherScreen";
  const BoycottIsraeliTechLancherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Override>>(
        future: Future.sync(BoycottIsraeliTechApp.overridesRiverpod),
        builder: (context, overrides) {
          if (overrides.data == null) {
            return Container();
          }
          return WillPopScope(
            onWillPop: () async {
              AppRouter.currentRouter?.pop();
              //boycottIsraeliTechRouter.pop();
              return false;
            },
            child: ProviderScope(overrides: overrides.data!, child: const BoycottIsraeliTechApp()),
          );
        });
  }
}
