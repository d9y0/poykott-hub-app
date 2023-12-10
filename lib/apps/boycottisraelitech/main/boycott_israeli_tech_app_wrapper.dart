/*import 'package:boycott_all_in_one/features/app_prefix/app_prefix_provider.dart';
import 'package:boycott_all_in_one/features/auto_router_observer/providers_override.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoycottIsraeliTechAppWrapperr extends StatelessWidget {
  final Widget child;

  const BoycottIsraeliTechAppWrapperr({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Override>>(future: Future.sync(() async {
      return [
        appPrefix.overrideWith((ref) => 'BoycottIsraeliTechAppWrapper_'),
        ...AutoRouterObserverProvidersOverride.override(),
      ];
    }), builder: (context, overrides) {
      if (overrides.data == null) {
        return Container();
      }
      return ProviderScope(overrides: overrides.data!, child: child);
    });
  }
}*/


//boycott_israeli_tech_app_wrapper
//BoycottIsraeliTechAppWrapper