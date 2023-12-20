import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:boycott_hub/apps/boycottisraelitech/features/dio/services/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompaniesRepository {
  static final provider = Provider((ref) => CompaniesRepository(dio: ref.read(DioService.provider).dio), dependencies: [DioService.provider]);
  final Dio dio;

  CompaniesRepository({required this.dio});
  Future<Response<Map?>> getIsraelCompaniesServices({String? eTag}) async {
    final res = await dio.get<Map?>(
      'https://boycottisraelitech.com/israel-companies-services.json',
      options: Options(
        headers: {"If-None-Match": eTag},
      ),
    );
    return res;
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
