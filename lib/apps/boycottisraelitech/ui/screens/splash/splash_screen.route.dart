import 'package:auto_route/auto_route.dart';
import 'package:boycott_hub/apps/boycottisraelitech/route/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:async';

@RoutePage(
  name: SplashScreen.name,
)
class SplashScreen extends ConsumerStatefulWidget {
  static const name = "BoycottIsraeliTech_SplashScreenRoute";
  static const path = "/SplashScreen";
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(
          seconds: 3,
        ), () {
      AutoRouter.of(context).replace(const BoycottIsraeliTech_HomeScreenRoute());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "Boycott Israeli Tech App",
        style: Theme.of(context).textTheme.bodyLarge,
      )),
    );
  }
}
