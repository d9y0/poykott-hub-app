import 'dart:convert';
import 'dart:typed_data';

import 'package:boycott_hub/features/config/data/models/config/config_res_model.dart';
import 'package:boycott_hub/features/config/data/repositories/config_repository.dart';
import 'package:boycott_hub/features/etag_management/services/etag_management_service.dart';
import 'package:dio/dio.dart';

class ConfigService {
  final ConfigRepository configRepository;
  final EtagManagementService etagApiCacheService;
  final List<String> configsUrls;
  ConfigService({
    required this.configRepository,
    required this.etagApiCacheService,
    required this.configsUrls,
  });

  Future<ConfigResModel> getConfig() async {
    final List<Object> errors = [];
    for (String url in configsUrls) {
      try {
        final cacheEtag = await etagApiCacheService.getEtag(url);
        final res = await configRepository.getConfig(url: url, eTag: cacheEtag);
        if (res.statusCode == 200 && res.headers.value("etag") != null) {
          Uint8List bytes = Uint8List.fromList(utf8.encode(json.encode(res.data)));
          etagApiCacheService.save(url, res.headers.value("etag")!, bytes);
        }

        final ConfigResModel configResModel = ConfigResModel.fromJson(res.data!);

        return configResModel;
      } on DioException catch (e) {
        if (e.response?.statusCode == 304 || e.type == DioExceptionType.connectionError) {
          final dataCache = await etagApiCacheService.getData(url);

          if (dataCache != null) {
            final Map<String, dynamic> data = json.decode(utf8.decode(dataCache.toList())) as Map<String, dynamic>;
            return ConfigResModel.fromJson(data);
          }
        }
        errors.add(e);
        continue;
      } catch (e) {
        errors.add(e);
        continue;
      }
    }

    throw errors;
  }
}
