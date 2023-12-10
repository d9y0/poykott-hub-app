import 'dart:async';

import 'package:boycott_hub/apps/boycottisraelitech/features/companies/models/company_res_model.dart';
import 'package:boycott_hub/apps/boycottisraelitech/features/companies/services/companies_service.dart';
import 'package:boycott_hub/features/shared_states/search_state/search_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SearchType {
  all,
  byName,
  byDescription,
}

class CompaniesStateProviders {
  static final searchTypeStateProvider = StateProvider<SearchType>((ref) => throw UnimplementedError());
  static SearchType searchTypeStateProviderFn(StateProviderRef<SearchType> ref) {
    return SearchType.all;
  }

  static final companiesApiProvider = FutureProvider.autoDispose<List<CompanyModel>>(
    (ref) async => throw UnimplementedError(),
    dependencies: [CompaniesService.provider],
  );
  static FutureOr<List<CompanyModel>> companiesApiProviderFn(AutoDisposeFutureProviderRef<List<CompanyModel>> ref) async {
    final companiesService = ref.read(CompaniesService.provider);
    final models = await companiesService.getIsraelCompaniesServices();
    ref.keepAlive();

    return models;
  }

  static final allCategoresProvider = FutureProvider.autoDispose<List<String>>(
    (ref) async => throw UnimplementedError(),
    dependencies: [companiesApiProvider],
  );
  static FutureOr<List<String>> allCategoresProviderFn(AutoDisposeFutureProviderRef<List<String>> ref) async {
    final List<String> list = [];
    final allCompanies = await ref.watch(companiesApiProvider.future);

    final cache = allCompanies.where((element) => element.fixedCategory.isNotEmpty).map((e) => e.fixedCategory).toList();

    cache.forEach((element) {
      if (!list.contains(element)) {
        list.add(element);
      }
    });
    return list;
  }

  static final selectedCategoresStateProvider = StateProvider.autoDispose<AsyncValue<List<String>>>(
    (ref) => throw UnimplementedError(),
    dependencies: [allCategoresProvider],
  );
  static AsyncValue<List<String>> selectedCategoresStateProviderFn(AutoDisposeStateProviderRef<AsyncValue<List<String>>> ref) {
    final a = ref.watch(allCategoresProvider);
    ref.keepAlive();
    return a;
  }

  static final companiesHasValueProvider = Provider.autoDispose<bool>((ref) {
    final v = ref.watch(companiesApiProvider);

    return v.hasValue;
  }, dependencies: [companiesApiProvider]);
  static bool companiesHasValueProviderFn(AutoDisposeProviderRef<bool> ref) {
    final v = ref.watch(companiesApiProvider);

    return v.hasValue;
  }

  static final companiesSearchProvider = FutureProvider.autoDispose<List<CompanyModel>>((ref) async => throw UnimplementedError(),
      dependencies: [companiesApiProvider, searchStateProvider, searchTypeStateProvider, selectedCategoresStateProvider]);

  static FutureOr<List<CompanyModel>> companiesSearchProviderFn(AutoDisposeFutureProviderRef<List<CompanyModel>> ref) async {
    final searchValue = ref.watch(searchStateProvider).toLowerCase();
    final categores = ref.watch(selectedCategoresStateProvider);
    final allCompanies = await ref.watch(companiesApiProvider.future);
    List<CompanyModel> list = [];

    if (searchValue.isEmpty) {
      list = allCompanies;
    } else {
      final searchType = ref.watch(searchTypeStateProvider);

      if (searchType == SearchType.byDescription) {
        list = allCompanies.where((element) => element.description.toLowerCase().contains(searchValue)).toList();
      } else if (searchType == SearchType.byName) {
        list = allCompanies.where((element) => element.name.toLowerCase().contains(searchValue)).toList();
      } else {
        list = allCompanies.where((element) {
          return element.name.toLowerCase().contains(searchValue) || element.description.toLowerCase().contains(searchValue);
        }).toList();
      }
    }

    return list.where((element) {
      return categores.value?.map((e) => e.toLowerCase()).contains(element.fixedCategory.toLowerCase()) ?? true;
    }).toList();
  }

  static List<Override> getOverrides() {
    return [
      searchTypeStateProvider.overrideWith(searchTypeStateProviderFn),
      companiesApiProvider.overrideWith(companiesApiProviderFn),
      allCategoresProvider.overrideWith(allCategoresProviderFn),
      selectedCategoresStateProvider.overrideWith(selectedCategoresStateProviderFn),
      companiesHasValueProvider.overrideWith(companiesHasValueProviderFn),
      companiesSearchProvider.overrideWith(companiesSearchProviderFn),
    ];
  }
}
