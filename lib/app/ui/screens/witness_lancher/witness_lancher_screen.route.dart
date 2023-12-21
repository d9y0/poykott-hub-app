import 'package:auto_route/auto_route.dart';
import 'package:boycott_hub/apps/witness/main/witness_app.dart';
import 'package:boycott_hub/apps/witness/route/witness_app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage(
  name: WitnessLancherScreen.name,
)
class WitnessLancherScreen extends StatelessWidget {
  static const name = "WitnessLancherScreenRoute";
  static const path = "/witnessLancherScreen";
  const WitnessLancherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Override>>(
        future: Future.sync(WitnessApp.overridesRiverpod),
        builder: (context, overrides) {
          if (overrides.data == null) {
            return Container();
          }
          return WillPopScope(
            onWillPop: () async {
              //boycottIsraeliTechRouter.pop();
              if (WitnessAppRouter.currentRouter?.current.name == "Witness_HomeScreenRoute") {
                return true;
              }

              WitnessAppRouter.currentRouter?.pop();

              return false;
            },
            child: ProviderScope(overrides: overrides.data!, child: const WitnessApp()),
          );
        });
  }
}
