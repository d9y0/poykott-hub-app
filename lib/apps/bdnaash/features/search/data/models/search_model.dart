import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_model.freezed.dart';
part 'search_model.g.dart';

@freezed
class SearchModel with _$SearchModel {
  factory SearchModel({
    required bool status,
    required String msg,
    required Data data,
    required String html,
    required String statusClass,
    required String type,
    required String post_data,
    required String request_counters,
  }) = _SearchModel;

  factory SearchModel.fromJson(Map<String, dynamic> json) => _$SearchModelFromJson(json);
}

@freezed
class Data with _$Data {
  factory Data({
    String? query,
    String? type,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
