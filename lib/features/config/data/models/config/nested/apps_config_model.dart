import 'package:boycott_hub/features/config/data/models/config/nested/witness_app_config_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'apps_config_model.freezed.dart';
part 'apps_config_model.g.dart';

@freezed
class AppsConfigModel with _$AppsConfigModel {
  factory AppsConfigModel({
    @JsonKey(name: 'witness_app_config') required WitnessAppConfigModel witnessAppConfig,
  }) = _AppsConfigModel;

  factory AppsConfigModel.fromJson(Map<String, dynamic> json) => _$AppsConfigModelFromJson(json);
}
