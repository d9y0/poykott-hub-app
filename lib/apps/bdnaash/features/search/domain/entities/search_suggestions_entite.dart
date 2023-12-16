import 'package:freezed_annotation/freezed_annotation.dart';
part 'search_suggestions_entite.freezed.dart';
part 'search_suggestions_entite.g.dart';

@freezed
class SearchSuggestionsEntite with _$SearchSuggestionsEntite {
  factory SearchSuggestionsEntite({
    @Default([]) List<SearchSuggestionEntite> list,
  }) = _SearchSuggestionsEntite;

  factory SearchSuggestionsEntite.fromJson(Map<String, dynamic> json) => _$SearchSuggestionsEntiteFromJson(json);
}

@freezed
class SearchSuggestionEntite with _$SearchSuggestionEntite {
  factory SearchSuggestionEntite({
    required String title,
  }) = _SearchSuggestionEntite;

  factory SearchSuggestionEntite.fromJson(Map<String, dynamic> json) => _$SearchSuggestionEntiteFromJson(json);
}
