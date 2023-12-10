// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:async';

import 'dart:io';

import 'package:boycott_hub/apps/boycottisraelitech/features/companies/services/companies_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final FutureOr<File?> Function(AutoDisposeFutureProviderRef<File?>, String) cachedLogoProviderFn = (ref, url) async {
  final companiesService = ref.read(CompaniesService.provider);
  final a = await companiesService.getLogo(url);
  ref.keepAlive();

  return a;
};

final cachedLogoProvider = FutureProvider.family.autoDispose<File?, String>(cachedLogoProviderFn, dependencies: [CompaniesService.provider]);
