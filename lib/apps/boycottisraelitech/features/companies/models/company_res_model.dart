import 'package:boycott_hub/apps/boycottisraelitech/features/companies/models/alternative_model.dart';
import 'package:boycott_hub/apps/boycottisraelitech/features/companies/models/resource_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import "package:path/path.dart" as path;

part 'company_res_model.freezed.dart';
part 'company_res_model.g.dart';

@freezed
class CompanyModel with _$CompanyModel {
  const CompanyModel._();
  factory CompanyModel({
    required int id,
    required String name,
    required String description,
    required String logo,
    @Default("") String notes,
    required String category,
    @Default([]) List<AlternativeModel> alternatives,
    @Default([]) List<ResourceModel> resources,

    // note: using an empty list as a default value
  }) = _CompanyModel;

  String get fixedLogo => "https://raw.githubusercontent.com/" + path.join("TheBSD/poykott/main/", logo.substring(2, logo.length));
  String get logoType => path.extension(logo);
  String get fixedCategory => category.isEmpty ? "unclassified" : category;
  String get arCategory {
    final _category = fixedCategory;
    if (_category.toLowerCase() == "ecommerce") {
      return "التجارة الإلكترونية";
    } else if (_category.toLowerCase() == "commerce") {
      return "التجارة";
    } else if (_category.toLowerCase() == "security") {
      return "الحماية";
    } else if (_category.toLowerCase() == "marketing") {
      return "التسويق";
    } else if (_category.toLowerCase() == "development") {
      return "التطوير";
    } else if (_category.toLowerCase() == "healthcare") {
      return "الرعاىة الصحية";
    } else if (_category.toLowerCase() == "sales") {
      return "المبيعات";
    } else if (_category.toLowerCase() == "productivity") {
      return "الإنتاجية";
    } else if (_category.toLowerCase() == "finance") {
      return "التمويل";
    } else if (_category.toLowerCase() == "semiconductors") {
      return "أشباه الموصلات";
    } else if (_category.toLowerCase() == "hr") {
      return "الموارد البشرية";
    } else if (_category.toLowerCase() == "ai") {
      return "الذكاء الاصطناعي";
    } else if (_category.toLowerCase() == "unclassified") {
      return "غير مصنف";
    }
    return _category;
  }

  factory CompanyModel.fromJson(Map<String, dynamic> json) => _$CompanyModelFromJson(json);
}
