import 'package:freezed_annotation/freezed_annotation.dart';

part 'witness_app_config_model.freezed.dart';
part 'witness_app_config_model.g.dart';

@freezed
class WitnessAppConfigModel with _$WitnessAppConfigModel {
  factory WitnessAppConfigModel({
    required String endpoint,
    @JsonKey(name: 'categories_list') required List<String> categoriesList,
  }) = _WitnessAppConfigModel;

  factory WitnessAppConfigModel.fromJson(Map<String, dynamic> json) => _$WitnessAppConfigModelFromJson(json);
}
