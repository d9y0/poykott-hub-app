import 'package:boycott_hub/apps/bdnaash/features/search/domain/entities/search_entite.dart';
import 'package:boycott_hub/apps/bdnaash/features/search/domain/entities/search_suggestions_entite.dart';

abstract class IFSearchRepository {
  Future<SearchSuggestionsEntite> getSearchSuggestions(String searchValue);
  Future<SearchEntite> getSearchResult(String searchValue);
}
