import 'package:boycott_hub/apps/boycottisraelitech/features/dio/services/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompaniesRepository {
  static final provider = Provider((ref) => CompaniesRepository(dio: ref.read(DioService.provider).dio), dependencies: [DioService.provider]);
  final Dio dio;

  CompaniesRepository({required this.dio});
  Future<Response<String?>> getIsraelCompaniesServices({String? eTag}) async {
    return dio.get<String?>(
      'https://raw.githubusercontent.com/TheBSD/poykott/main/israel-companies-services.json',
      options: Options(
        headers: {"If-None-Match": eTag},
      ),
    );
  }

  Future<Response> getLogo({String? eTag, required String url}) async {
    return dio.get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        headers: {"If-None-Match": eTag},
        followRedirects: false,
      ),
    );
  }
}
