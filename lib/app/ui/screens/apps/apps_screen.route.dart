import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:boycott_hub/app/features/apps/apps_provider.dart';
import 'package:boycott_hub/app/routes/app_route.dart';
import 'package:boycott_hub/ui/widgets/layer_widget.dart';
import 'package:boycott_hub/utile/color_converter.dart';
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
              child: SingleChildScrollView(
            child: Wrap(
              children: appList.map<Widget>((app) {
                return Container(
                  width: 140,
                  height: 128,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: InkWellLayerWidget(
                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: EdgeInsets.only(bottom: 8, top: 8, left: 5, right: 5),
                          width: 140,
                          height: 128,
                          color: ColorConverter.hexStringToColor(app.backgroundColor),
                          onTap: () async {
                            await AutoRouter.of(context).pushNamed(app.appPath);
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            children: [
                              /*Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.info,
                                    ),
                                  )
                                ],
                              ),*/
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
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                      color: ColorConverter.hexStringToColor(app.forgroundColor),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 5,
                        top: 0,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.info,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          )

              /*GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: appList.map<Widget>((app) {
                return InkWellLayerWidget(
                  color: ColorConverter.hexStringToColor(app.backgroundColor),
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
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: ColorConverter.hexStringToColor(app.forgroundColor),
                            ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),*/
              )
        ],
      ),
    );
  }
}
