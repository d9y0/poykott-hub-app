import 'package:boycott_hub/apps/bdnaash/features/search/data/repositories/search_network_repository.dart';
import 'package:boycott_hub/apps/bdnaash/features/search/domain/services/search_service.dart';
import 'package:boycott_hub/features/dio/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchProviders {
  /// Search Network repository
  //SearchNetworkRepository
  static final Provider<SearchNetworkRepository> searchNetworkRepositoryProvider = Provider<SearchNetworkRepository>(
    (ref) => throw UnimplementedError(),
    dependencies: [DioProvider.provider],
  );
  static SearchNetworkRepository searchNetworkRepositoryProviderFn(ProviderRef<SearchNetworkRepository> ref) {
    return SearchNetworkRepository(dio: ref.read(DioProvider.provider));
  }

  ///Search Service
  //SearchService
  static final Provider<SearchService> searchServiceProvider = Provider<SearchService>(
    (ref) => throw UnimplementedError(),
    dependencies: [searchNetworkRepositoryProvider],
  );
  static SearchService searchServiceProviderFn(ProviderRef<SearchService> ref) {
    return SearchService(searchNetworkRepository: ref.read(searchNetworkRepositoryProvider));
  }

  static List<Override> overrides() {
    return [
      searchNetworkRepositoryProvider.overrideWith(searchNetworkRepositoryProviderFn),
      searchServiceProvider.overrideWith(searchServiceProviderFn),
    ];
  }
}
