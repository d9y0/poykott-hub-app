import 'package:boycott_hub/features/config/data/models/config/nested/apps_config_model.dart';
import 'package:boycott_hub/features/config/data/models/config/nested/chngelog_model.dart';
import 'package:boycott_hub/features/config/data/models/config/nested/update_info_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_res_model.freezed.dart';
part 'config_res_model.g.dart';

@freezed
class ConfigResModel with _$ConfigResModel {
  const ConfigResModel._();
  factory ConfigResModel({
    @JsonKey(
      name: 'configs_urls',
      //fromJson: ConfigResModel._configsUrlsFromJson,
    )
    required List<String> configs,
    @JsonKey(name: 'update_info') required UpdateInfoModel updateInfo,
    required List<ChngelogModel> chngelog,
    @JsonKey(name: 'main_dynamic_widget') required Map<String, dynamic> mainDynamicWidget,
    @JsonKey(name: 'apps_config') required AppsConfigModel appsConfig,
  }) = _ConfigResModel;

  factory ConfigResModel.fromJson(Map<String, dynamic> json) => _$ConfigResModelFromJson(json);

  static List<String> _configsUrlsFromJson(dynamic json) {
    return json as List<String>;
  }
}
