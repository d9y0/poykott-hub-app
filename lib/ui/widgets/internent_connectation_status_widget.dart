import 'package:boycott_hub/app/ui/screens/boycott_israeli_tech_lancher/boycott_israeli_tech_lancher.route.dart';
import 'package:boycott_hub/app/ui/screens/splash/splash_screen.route.dart';
import 'package:boycott_hub/features/auto_router_observer/states/current_route_notifier_provider.dart';

import 'package:boycott_hub/features/internet_access_status/services/internet_access_status_service.dart';
import 'package:boycott_hub/features/internet_access_status/states/hide_on_status_online_notifier.dart';
import 'package:boycott_hub/features/internet_access_status/states/internet_access_status_notifier.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class InternentConnectationStatusWidget extends ConsumerWidget {
  static final _hideWheneProvider = Provider<bool>((ref) {
    final routeStackIteemModel = ref.watch(CurrentRouteNotifierProvider.notifierProvider);
    if (routeStackIteemModel.name == '') {
      return true;
    }
    final List<String> blackList = [
      SplashScreen.name,
      BoycottIsraeliTechLancherScreen.name,
    ];

    return blackList.contains(routeStackIteemModel.name);
  }, dependencies: [CurrentRouteNotifierProvider.notifierProvider]);

  const InternentConnectationStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hide = ref.watch(InternentConnectationStatusWidget._hideWheneProvider);
    //final routeStackIteemModel = ref.watch(CurrentRouteNotifierProvider.notifierProvider);

    final internetAccessStatusState = ref.watch(InternetAccessStatusNotifier.stateNotifierProvider);
    final hideOnStatusOnlineState = ref.watch(HideOnStatusOnlineNotifier.hideOnStatusOnlineStateNotifierProvider);

    if (hide) {
      return Container();
    }
    return AnimatedContainer(
      height: hideOnStatusOnlineState ? 0 : 20,
      color: internetAccessStatusState == InternetAccessStatus.online && !hideOnStatusOnlineState ? Colors.green : Colors.grey.shade800,
      duration: const Duration(milliseconds: 500),
      child: Center(
        child: Text(
          "${internetAccessStatusState == InternetAccessStatus.online ? 'Online' : 'Offline'}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
