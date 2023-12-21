import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:boycott_hub/apps/witness/route/witness_app_routes.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage(
  name: HomeScreen.name,
)
class HomeScreen extends ConsumerWidget {
  static const name = "witness_HomeScreenRoute";
  static const path = "/home";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2));
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: AutoSizeText(
                "The Witness",
                softWrap: false,
                maxLines: 1,
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    AutoRouter.of(context).push(Witness_SettingsScreenRoute());
                  },
                ),
              ],
              centerTitle: true,
              floating: true,
              pinned: false,
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          "Support Palestine. Boycott Israel",
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Stand with the Palestinians in their struggle for freedom, justice, and equality. Whilst our governments financially support the apartheid state, we don't have to.",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "PLEASE NOTE: This list is not complete and is constantly being added to. If you know about a brand that should be on the list, please use the Something missing button below to submit it. Thanks.",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
