import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_model.freezed.dart';

@freezed
class AppModel with _$AppModel {
  const AppModel._();
  const factory AppModel({
    required int id,
    required String displayName,
    required String description,
    required String img,
    required String website,
    required String appPath,
  }) = _AppModel;
}
