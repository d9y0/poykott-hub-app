import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:boycott_hub/app/features/apps/apps_provider.dart';
import 'package:boycott_hub/app/routes/app_route.dart';
import 'package:boycott_hub/ui/widgets/layer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gap/gap.dart';

@RoutePage(
  name: AppsScreen.name,
)
class AppsScreen extends ConsumerWidget {
  static const name = "AppsScreenRoute";
  static const path = "/AppsScreenRoute";
  const AppsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appList = ref.watch(appsModelsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Boycott Hub"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              AutoRouter.of(context).push(const SettingsScreenRoute());
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: appList.map<Widget>((app) {
                return InkWellLayerWidget(
                  onTap: () async {
                    await AutoRouter.of(context).pushNamed(app.appPath);
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          app.img,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Gap(5),
                      AutoSizeText(
                        "${app.displayName}",
                        //style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                        maxLines: 1, // Limit the text to 2 lines
                        minFontSize: 12.0, // Minimum font size
                        overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
