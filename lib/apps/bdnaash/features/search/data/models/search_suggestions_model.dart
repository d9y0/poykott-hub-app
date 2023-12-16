import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_suggestions_model.freezed.dart';
part 'search_suggestions_model.g.dart';

@freezed
class SearchSuggestionsModel with _$SearchSuggestionsModel {
  factory SearchSuggestionsModel({
    bool? status,
    String? msg,
    @Default([]) List<Data> data,
    String? html,
  }) = _SearchSuggestionsModel;

  factory SearchSuggestionsModel.fromJson(Map<String, dynamic> json) => _$SearchSuggestionsModelFromJson(json);
}

@freezed
class Data with _$Data {
  factory Data({
    required String title,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
