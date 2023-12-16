import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_entite.freezed.dart';
part 'search_entite.g.dart';

@freezed
class SearchEntite with _$SearchEntite {
  factory SearchEntite({
    required bool isSupportingZion,
    required String name,
    required String request_counters,
  }) = _SearchEntite;

  factory SearchEntite.fromJson(Map<String, dynamic> json) => _$SearchEntiteFromJson(json);
}
