import 'package:freezed_annotation/freezed_annotation.dart';

part 'chngelog_model.freezed.dart';
part 'chngelog_model.g.dart';

@freezed
class ChngelogModel with _$ChngelogModel {
  factory ChngelogModel({
    required String version,
    required List<String> chngelogs,
    @JsonKey(name: 'apk_urls') required List<String> apkUrls,
    @JsonKey(name: 'ipa_urls') required List<String> ipaUrls,
  }) = _ChngelogModel;

  factory ChngelogModel.fromJson(Map<String, dynamic> json) => _$ChngelogModelFromJson(json);
}
