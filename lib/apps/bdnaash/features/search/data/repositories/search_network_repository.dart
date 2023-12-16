import 'dart:convert';

import 'package:boycott_hub/apps/bdnaash/features/search/data/models/search_model.dart';
import 'package:boycott_hub/apps/bdnaash/features/search/data/models/search_suggestions_model.dart';
import 'package:boycott_hub/apps/bdnaash/features/search/domain/entities/search_entite.dart';
import 'package:boycott_hub/apps/bdnaash/features/search/domain/entities/search_suggestions_entite.dart';
import 'package:boycott_hub/apps/bdnaash/features/search/domain/repositories/search_repository.dart';
import 'package:dio/dio.dart';

class SearchNetworkRepository implements IFSearchRepository {
  final Dio dio;

  SearchNetworkRepository({required this.dio});

  @override
  Future<SearchEntite> getSearchResult(String searchValue) async {
    try {
      final response = await dio.post('https://bdnaash.com/search',
          data: {"query": searchValue, "type": "Keyword"},
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {"X-Requested-With": "XMLHttpRequest"},
          ));
      final searchModel = SearchModel.fromJson(json.decode(response.data));
      final bool isSupportingZion = searchModel.statusClass == "b-red" ? true : false;

      return SearchEntite(isSupportingZion: isSupportingZion, name: searchModel.post_data, request_counters: searchModel.request_counters);
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<SearchSuggestionsEntite> getSearchSuggestions(String searchValue) async {
    try {
      final response = await dio.post('https://bdnaash.com/home/searchSuggestions',
          data: {
            "query": searchValue,
          },
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {"X-Requested-With": "XMLHttpRequest" as dynamic},
          ));

      final searchModel = SearchSuggestionsModel.fromJson(json.decode(response.data));

      final g = SearchSuggestionsEntite(list: [...searchModel.data.map((e) => SearchSuggestionEntite(title: e.title)).toList()]);

      return g;
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}
