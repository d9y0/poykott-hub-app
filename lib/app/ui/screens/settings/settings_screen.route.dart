import 'package:auto_route/auto_route.dart';

import 'package:boycott_hub/features/theme_mode/theme_mode_providers.dart';
import 'package:boycott_hub/ui/widgets/layer_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gap/gap.dart';

@RoutePage(
  name: SettingsScreen.name,
)
class SettingsScreen extends ConsumerWidget {
  static const name = "SettingsScreenRoute";
  static const path = "/settingsScreen";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(20),
                  ContainerLayerWidget(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    borderRadius: BorderRadius.circular(6),
                    elevation: 7,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    padding: const EdgeInsets.only(bottom: 20, top: 10, left: 10, right: 10),
                    // const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Theme Mode",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                        Gap(15),
                        Consumer(
                          builder: (context, ref, child) {
                            final themeMode = ref.watch(themeModeNotifier);
                            final themeMode_Notifier = ref.watch(themeModeNotifier.notifier);
                            return Column(
                              children: [
                                InkWellLayerWidget(
                                  elevation: 8,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8)),
                                  onTap: () {
                                    themeMode_Notifier.setLight();
                                  },
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  color: Theme.of(context).colorScheme.secondaryContainer,
                                  child: Row(
                                    children: [
                                      themeMode == ThemeMode.light ? Icon(Icons.radio_button_on) : Icon(Icons.radio_button_off),
                                      Expanded(
                                          child: Center(
                                        child: Text(
                                          "Light Theme",
                                          style: Theme.of(context).textTheme.bodyLarge,
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                                Divider(
                                  endIndent: 0,
                                  height: 1.5,
                                ),
                                InkWellLayerWidget(
                                  elevation: 8,
                                  onTap: () {
                                    themeMode_Notifier.setDark();
                                  },
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  color: Theme.of(context).colorScheme.secondaryContainer,
                                  child: Row(
                                    children: [
                                      themeMode == ThemeMode.dark ? Icon(Icons.radio_button_on) : Icon(Icons.radio_button_off),
                                      Expanded(
                                          child: Center(
                                        child: Text(
                                          "Dark Theme",
                                          style: Theme.of(context).textTheme.bodyLarge,
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                                Divider(
                                  endIndent: 0,
                                  height: 1.5,
                                ),
                                InkWellLayerWidget(
                                  elevation: 8,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                                  onTap: () {
                                    themeMode_Notifier.setSystem();
                                  },
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  color: Theme.of(context).colorScheme.secondaryContainer,
                                  child: Row(
                                    children: [
                                      themeMode == ThemeMode.system ? Icon(Icons.radio_button_on) : Icon(Icons.radio_button_off),
                                      Expanded(
                                          child: Center(
                                        child: Text(
                                          "System Theme",
                                          style: Theme.of(context).textTheme.bodyLarge,
                                        ),
                                      ))
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  Gap(20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
