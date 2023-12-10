import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InternetAccessStatusRepository {
  static final provider = Provider<InternetAccessStatusRepository>(
    (ref) => InternetAccessStatusRepository(),
  );

  /// other link http://connectivitycheck.gstatic.com/generate_204
  static const url = 'http://google.com/generate_204';
  final dio = Dio(BaseOptions(
    receiveTimeout: Duration(seconds: 2),
    connectTimeout: Duration(seconds: 2),
    sendTimeout: Duration(seconds: 2),
  ));

  Future<Response<void>> call({CancelToken? cancelToken}) async {
    final Future<Response<void>> res = dio.get(InternetAccessStatusRepository.url, cancelToken: cancelToken);

    return res;
  }
}
