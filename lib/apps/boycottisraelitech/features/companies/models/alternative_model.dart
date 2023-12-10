import 'package:freezed_annotation/freezed_annotation.dart';

part 'alternative_model.freezed.dart';
part 'alternative_model.g.dart';

@freezed
class AlternativeModel with _$AlternativeModel {
  factory AlternativeModel({
    required String name,
    required String description,
    required String link,
    required String logo,
    required String notes,
  }) = _AlternativeModel;

  factory AlternativeModel.fromJson(Map<String, dynamic> json) => _$AlternativeModelFromJson(json);
}
