import 'package:auto_route/auto_route.dart';
import 'package:boycott_hub/apps/boycottisraelitech/features/companies/states/companies_api_provider.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

@RoutePage(
  name: SearchFilter.name,
)
class SearchFilter extends ConsumerWidget {
  static const name = "BoycottIsraeliTech_SearchFiltersBottomSheetsRoute";
  static const path = "/SearchFilters";
  const SearchFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "فلتر البحث",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap(10),
        Consumer(builder: (context, ref, child) {
          final searchType = ref.watch(CompaniesStateProviders.searchTypeStateProvider);
          final searchTypeNotifier = ref.read(CompaniesStateProviders.searchTypeStateProvider.notifier);
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Row(
                  children: [Text("البحث بواسطة:", style: Theme.of(context).textTheme.bodyLarge)],
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: searchType == SearchType.all
                          ? null
                          : () {
                              searchTypeNotifier.state = SearchType.all;
                            },
                      icon: searchType == SearchType.all ? Icon(Icons.done) : Container(),
                      label: Text("الكل"),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(width: 1, color: Theme.of(context).indicatorColor),
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: searchType == SearchType.byName
                          ? null
                          : () {
                              searchTypeNotifier.state = SearchType.byName;
                            },
                      icon: searchType == SearchType.byName ? Icon(Icons.done) : Container(),
                      label: Text("بالاسم"),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(width: 1, color: Theme.of(context).indicatorColor),
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: searchType == SearchType.byDescription
                          ? null
                          : () {
                              searchTypeNotifier.state = SearchType.byDescription;
                            },
                      icon: searchType == SearchType.byDescription ? Icon(Icons.done) : Container(),
                      label: Text("بالوصف"),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(width: 1, color: Theme.of(context).indicatorColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
        Gap(10),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Text("فلتر بالنوع:", style: Theme.of(context).textTheme.bodyLarge)),
                    IconButton(
                        onPressed: () async {
                          final selectedCategoresNotifier = ref.read(CompaniesStateProviders.selectedCategoresStateProvider.notifier);
                          final allCats = await ref.read(CompaniesStateProviders.allCategoresProvider.future);
                          if (allCats.length == selectedCategoresNotifier.state.value?.length) {
                            return;
                          }
                          selectedCategoresNotifier.state = AsyncValue.data(allCats);
                        },
                        icon: Icon(Icons.done_all)),
                    IconButton(
                        onPressed: () {
                          final selectedCategoresNotifier = ref.read(CompaniesStateProviders.selectedCategoresStateProvider.notifier);
                          if (selectedCategoresNotifier.state.value!.isEmpty) {
                            return;
                          }

                          ref.read(CompaniesStateProviders.selectedCategoresStateProvider.notifier).state = AsyncValue.data([]);
                        },
                        icon: Icon(Icons.clear_all)),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.maxFinite,
                      child: Consumer(builder: (context, ref, child) {
                        final selectedCategores = ref.watch(CompaniesStateProviders.selectedCategoresStateProvider);
                        final selectedCategoresNotifier = ref.read(CompaniesStateProviders.selectedCategoresStateProvider.notifier);

                        return ref.watch(CompaniesStateProviders.allCategoresProvider).when(
                            data: (categores) {
                              return Wrap(
                                runSpacing: 10,
                                spacing: 10,
                                children: categores.map((categorey) {
                                  final isSelected = selectedCategores.value!.contains(categorey);

                                  return TextButton.icon(
                                    onPressed: () {
                                      if (isSelected) {
                                        final cacheState = [...selectedCategoresNotifier.state.value!];
                                        cacheState.remove(categorey);
                                        selectedCategoresNotifier.state = AsyncValue.data(cacheState);
                                      } else {
                                        selectedCategoresNotifier.state = AsyncValue.data([...selectedCategoresNotifier.state.value!, categorey]);
                                      }
                                    },
                                    icon: isSelected ? Icon(Icons.done, size: 18) : Container(),
                                    label: Text(categorey),
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.onSecondary.withOpacity(0.4))),
                                  );
                                }).toList(),
                              );
                            },
                            error: (e, t) => Container(),
                            loading: () => Container());
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
