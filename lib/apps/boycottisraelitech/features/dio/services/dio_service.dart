import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioService {
  static Future<DioService Function(ProviderRef<DioService>)> Function() providerRefFn = () async {
    final service = DioService();

    await service._initializeDio();
    return (ref) {
      return service;
    };
  };
  static Provider<DioService> provider = Provider<DioService>((ref) => throw UnimplementedError());

  late Dio dio;

  Future<void> _initializeDio() async {
    dio = Dio(
      BaseOptions(
          //connectTimeout: Duration(seconds: 2),
          //receiveTimeout: Duration(seconds: 2),
          /*validateStatus: (status) {
          return (status != null && ((status >= 200 && status < 300) || status == 304));
        },*/
          //responseType: ResponseType.json,
          ),
    );
  }
}
