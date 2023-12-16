import 'package:boycott_hub/apps/bdnaash/features/search/data/repositories/search_network_repository.dart';
import 'package:boycott_hub/apps/bdnaash/features/search/domain/entities/search_entite.dart';
import 'package:boycott_hub/apps/bdnaash/features/search/domain/entities/search_suggestions_entite.dart';

class SearchService {
  final SearchNetworkRepository searchNetworkRepository;

  SearchService({required this.searchNetworkRepository});

  Future<SearchSuggestionsEntite> getSearchSuggestions(String searchValue) async {
    return await searchNetworkRepository.getSearchSuggestions(searchValue);
  }

  Future<SearchEntite> getSearchResult(String searchValue) async {
    return searchNetworkRepository.getSearchResult(searchValue);
  }
}
