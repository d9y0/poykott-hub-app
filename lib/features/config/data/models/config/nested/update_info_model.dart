import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_info_model.freezed.dart';
part 'update_info_model.g.dart';

@freezed
class UpdateInfoModel with _$UpdateInfoModel {
  factory UpdateInfoModel({
    @JsonKey(name: 'last_version') required String lastVersion,
    @JsonKey(name: 'last_apk_url') required String lastApkUrl,
    @JsonKey(name: 'last_ipa_url') required String lastIpaUrl,
  }) = _UpdateInfoModel;

  factory UpdateInfoModel.fromJson(Map<String, dynamic> json) => _$UpdateInfoModelFromJson(json);
}
