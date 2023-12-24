import 'package:dio/dio.dart';

class ConfigRepository {
  final Dio dio;

  ConfigRepository({
    required this.dio,
  });

  Future<Response<Map<String, dynamic>>> getConfig({required String url, String? eTag}) async {
    final res = await dio.get<Map<String, dynamic>>(
      url,
      options: Options(
        headers: {"If-None-Match": eTag},
      ),
    );
    return res;
  }
}
