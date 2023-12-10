import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource_model.freezed.dart';
part 'resource_model.g.dart';

@freezed
class ResourceModel with _$ResourceModel {
  factory ResourceModel({
    required String name,
    @Default("") String link,
  }) = _ResourceModel;

  factory ResourceModel.fromJson(Map<String, dynamic> json) => _$ResourceModelFromJson(json);
}
