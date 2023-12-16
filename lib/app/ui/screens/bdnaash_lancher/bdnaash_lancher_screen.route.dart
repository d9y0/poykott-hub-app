//bdnaash_lancher_screen

import 'package:auto_route/auto_route.dart';
import 'package:boycott_hub/apps/bdnaash/main/bdnaash_app.dart';
import 'package:boycott_hub/apps/bdnaash/routes/bdnaash_app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage(
  name: BdnaashLancherScreen.name,
)
class BdnaashLancherScreen extends StatelessWidget {
  static const name = "BdnaashLancherScreenRoute";
  static const path = "/bdnaashLancherScreen";
  const BdnaashLancherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Override>>(
        future: Future.sync(BdnaashApp.overridesRiverpod),
        builder: (context, overrides) {
          if (overrides.data == null) {
            return Container();
          }
          return WillPopScope(
            onWillPop: () async {
              BdnaashAppRouter.currentRouter?.pop();
              //boycottIsraeliTechRouter.pop();
              return false;
            },
            child: ProviderScope(overrides: overrides.data!, child: const BdnaashApp()),
          );
        });
  }
}
