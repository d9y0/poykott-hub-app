import 'package:boycott_hub/apps/bdnaash/features/search/domain/entities/search_entite.dart';
import 'package:boycott_hub/apps/bdnaash/features/search/domain/entities/search_suggestions_entite.dart';
import 'package:boycott_hub/apps/bdnaash/features/search/presentation/providers/search_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatesProviders {
  /// Searche Controller
  static final Provider<SearchController> searchControllerProvider = Provider<SearchController>(
    (ref) => throw UnimplementedError(),
  );
  static SearchController searchControllerProviderFn(ProviderRef<SearchController> ref) {
    final controller = SearchController();
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
  }

  static final StateProvider<String> currentSearchProviderState = StateProvider<String>((ref) => throw UnimplementedError(), dependencies: [searchControllerProvider]);

  static String currentSearchProviderStateFn(StateProviderRef<String> ref) {
    final controller = ref.read(searchControllerProvider);

    controller.addListener(() {
      ref.controller.update((state) => controller.text);
    });

    return controller.text;
  }

  //
  static final searchSuggestionsProvider = FutureProvider<SearchSuggestionsEntite?>((ref) async {
    throw UnimplementedError();
  }, dependencies: [
    SearchProviders.searchServiceProvider,
    currentSearchProviderState,
  ]);
  static Future<SearchSuggestionsEntite?> searchSuggestionsProviderFn(FutureProviderRef<SearchSuggestionsEntite?> ref) async {
    final service = ref.read(SearchProviders.searchServiceProvider);
    String currentSearch = ref.watch(currentSearchProviderState);

    if (currentSearch.isEmpty) {
      return null;
    }

    final res = await service.getSearchSuggestions(currentSearch);

    //ref.keepAlive();
    return res;
  }

  static final searchFutureProvider = FutureProvider<SearchEntite?>((ref) async {
    throw UnimplementedError();
  }, dependencies: [
    SearchProviders.searchServiceProvider,
    currentSearchProviderState,
  ]);

  static Future<SearchEntite?> searchFutureProviderFn(FutureProviderRef<SearchEntite?> ref) async {
    final service = ref.read(SearchProviders.searchServiceProvider);
    String currentSearch = ref.watch(currentSearchProviderState);
    if (currentSearch.isEmpty) {
      return null;
    }

    final res = await service.getSearchResult(currentSearch);

    //ref.keepAlive();
    return res;
  }

  static List<Override> overrides() {
    return [
      currentSearchProviderState.overrideWith(currentSearchProviderStateFn),
      searchSuggestionsProvider.overrideWith(searchSuggestionsProviderFn),
      searchControllerProvider.overrideWith(searchControllerProviderFn),
      searchFutureProvider.overrideWith(searchFutureProviderFn),
    ];
  }
}
