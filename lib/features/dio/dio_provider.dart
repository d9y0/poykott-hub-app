import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioProvider {
  static final Future<Dio Function(ProviderRef<Dio>)> Function({BaseOptions? dioBaseOptions}) _dioProviderRefFn = ({BaseOptions? dioBaseOptions}) async {
    final dio = Dio(dioBaseOptions ?? BaseOptions());
    return (ref) {
      return dio;
    };
  };

  static final Provider<Dio> provider = Provider<Dio>((ref) => throw UnimplementedError());

  static Future<List<Override>> override({BaseOptions? dioBaseOptions}) async {
    return [
      provider.overrideWith(
        await DioProvider._dioProviderRefFn(dioBaseOptions: dioBaseOptions),
      ),
    ];
  }
}
