import 'package:boycott_hub/features/app_prefix/app_prefix_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentViewStateProvider = StateProvider<String?>((ref) => throw UnimplementedError());
final currentViewStatePrefixProvider = StateProvider<String>((ref) => ref.watch(appPrefix) + (ref.watch(currentViewStateProvider) ?? ""), dependencies: [appPrefix, currentViewStateProvider]);
