import 'package:boycott_hub/features/config/data/constant.dart';
import 'package:boycott_hub/features/config/data/models/config/config_res_model.dart';
import 'package:boycott_hub/features/config/data/repositories/config_repository.dart';
import 'package:boycott_hub/features/config/domain/services/config_service.dart';
import 'package:boycott_hub/features/etag_management/services/etag_management_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

class ConfigProvider {
  static final Future<Dio Function(ProviderRef<Dio>)> Function({BaseOptions? dioBaseOptions}) _dioProviderRefFn = ({BaseOptions? dioBaseOptions}) async {
    final dio = Dio(dioBaseOptions ?? BaseOptions());
    return (ref) {
      return dio;
    };
  };

  static final Provider<Dio> dioProvider = Provider<Dio>((ref) => throw UnimplementedError());

  static final constantConfigsUrlsProvider = Provider<List<String>>(
    (ref) => configsUrls,
  );
  static final configRepositoryProvider = Provider<ConfigRepository>(
      (ref) => ConfigRepository(
            dio: ref.read(dioProvider),
          ),
      dependencies: [dioProvider]);

  static final configServiceProvider = Provider<ConfigService>(
      (ref) => ConfigService(
          configRepository: ref.read(configRepositoryProvider),
          configsUrls: ref.read(constantConfigsUrlsProvider),
          etagApiCacheService: ref.read(EtagManagementService.provider(Tuple2<String, String>.fromList(["", "api/config"])))),
      dependencies: [configRepositoryProvider, constantConfigsUrlsProvider, EtagManagementService.provider]);

  static final configFutureProvider = FutureProvider.autoDispose<ConfigResModel>(
    (ref) async {
      final configService = ref.read(configServiceProvider);
      try {
        final configResModel = await configService.getConfig();

        ref.keepAlive();
        return configResModel;
      } catch (e, t) {
        throw e;
      }
    },
    dependencies: [configServiceProvider],
  );

  static Future<List<Override>> override({BaseOptions? dioBaseOptions}) async {
    return [
      dioProvider.overrideWith(
        await ConfigProvider._dioProviderRefFn(dioBaseOptions: dioBaseOptions),
      ),
    ];
  }
}
