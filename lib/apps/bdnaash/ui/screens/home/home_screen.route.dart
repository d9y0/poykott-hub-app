import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:boycott_hub/apps/bdnaash/features/search/presentation/states/states_providers.dart';
import 'package:boycott_hub/apps/bdnaash/routes/bdnaash_app_routes.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

@RoutePage(
  name: HomeScreen.name,
)
class HomeScreen extends ConsumerWidget {
  static const name = "Bdnaash_HomeScreenRoute";
  static const path = "/home";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bdnaash"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              AutoRouter.of(context).push(const Bdnaash_SettingsScreenRoute());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: SvgPicture.asset(
                "assest/apps/bdnaash/logo.svg",
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: AutoSizeText(
                "منصة تدعم الاستهلاك الواعي من خلال تسهيل معرفة الشركات التي تدعم وتلك التي لا تدعم الاحتلال الإسرائيلي الغاشم لفلسطين",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Consumer(builder: (context, ref2, child) {
                      final asyncValueSearchSuggestionsEntite = ref2.watch(StatesProviders.searchSuggestionsProvider);
                      return SearchAnchor.bar(
                        viewLeading: IconButton(
                          onPressed: () {
                            ref2.read(StatesProviders.searchControllerProvider).clear();
                            ref2.read(StatesProviders.searchControllerProvider).closeView("");
                            ref2.read(StatesProviders.searchControllerProvider).openView();
                          },
                          icon: const Icon(Icons.close),
                        ),
                        viewTrailing: [
                          //CircularProgressIndicator(),
                          IconButton(
                            onPressed: () async {
                              final searchController = ref2.read(StatesProviders.searchControllerProvider);
                              searchController.closeView(searchController.text.toLowerCase());

                              final res = await ref2.read(StatesProviders.searchFutureProvider.future);

                              if (res != null) {
                                if (res.isSupportingZion) {
                                  await AutoRouter.of(context).push(Bdnaash_SupportZionDialogRoute(companyName: res.name));
                                } else {
                                  await AutoRouter.of(context).push(Bdnaash_NotSupportZionDialogRoute(companyName: res.name));
                                }
                              }
                            },
                            icon: const Icon(Icons.arrow_forward),
                          ),
                          if (asyncValueSearchSuggestionsEntite.isLoading) CircularProgressIndicator(),
                        ],
                        searchController: ref2.read(StatesProviders.searchControllerProvider),

                        /*builder: (BuildContext context, SearchController controller) {
                          return SearchBar(
                            controller: controller,
                            padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
                            onTap: () {
                              controller.openView();
                            },
                            onChanged: (value) {
                              //ref2.read(StatesProviders.currentSearchProviderState.notifier).update((state) => value);
                              controller.openView();
                              //controller.text = value;
                            },
                            leading: IconButton(onPressed: () {}, icon: Icon(Icons.camera)),
                            trailing: <Widget>[
                              Tooltip(
                                message: 'Change brightness mode',
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.search),
                                ),
                              )
                            ],
                          );
                        },*/
                        suggestionsBuilder: (BuildContext context, SearchController controller) async {
                          final value = await ref2.read(StatesProviders.searchSuggestionsProvider.future);

                          if (value == null) {
                            return [];
                          }

                          return value.list.map((e) {
                            return ListTile(
                              title: Text(e.title),
                              onTap: () async {
                                ref2.read(StatesProviders.searchControllerProvider).closeView(e.title);

                                final res = await ref2.read(StatesProviders.searchFutureProvider.future);
                                if (res != null) {
                                  if (res.isSupportingZion) {
                                    await AutoRouter.of(context).push(Bdnaash_SupportZionDialogRoute(companyName: e.title));
                                  } else {
                                    await AutoRouter.of(context).push(Bdnaash_NotSupportZionDialogRoute(companyName: e.title));
                                  }
                                }
                              },
                            );
                          });
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
