import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:boycott_hub/apps/boycottisraelitech/features/companies/constant.dart';
import 'package:boycott_hub/apps/boycottisraelitech/features/companies/models/company_res_model.dart';
import 'package:boycott_hub/apps/boycottisraelitech/features/companies/repositories/companies_repository.dart';

import 'package:boycott_hub/features/etag_management/services/etag_management_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompaniesService {
  static final provider = Provider(
    (ref) {
      return CompaniesService(
          companiesRepository: ref.read(CompaniesRepository.provider),
          etagApiCacheService: ref.read(EtagManagementService.provider("api")),
          etagImageCacheService: ref.read(EtagManagementService.provider("image")));
    },
    dependencies: [CompaniesRepository.provider, EtagManagementService.provider],
  );

  /*static final israelCompaniesServicesProvider = FutureProvider<List<CompanyModel>>((ref) async {
    final companiesService = ref.read(CompaniesService.provider);
    return await companiesService.getIsraelCompaniesServices();
  }, dependencies: [CompaniesService.provider]);*/

  final CompaniesRepository companiesRepository;
  final EtagManagementService etagApiCacheService;
  final EtagManagementService etagImageCacheService;

  CompaniesService({
    required this.companiesRepository,
    required this.etagApiCacheService,
    required this.etagImageCacheService,
  });
  Future<void> clear() async {
    await etagApiCacheService.remove(IsraelCompaniesServicesUrl);
  }

  Future<List<CompanyModel>> getIsraelCompaniesServices() async {
    try {
      final cacheEtag = await etagApiCacheService.getEtag(IsraelCompaniesServicesUrl);
      final res = await companiesRepository.getIsraelCompaniesServices(eTag: cacheEtag);

      if (res.statusCode == 200 && res.headers.value("etag") != null) {
        Uint8List bytes = Uint8List.fromList(utf8.encode(json.encode(res.data)));
        etagApiCacheService.save(IsraelCompaniesServicesUrl, res.headers.value("etag")!, bytes);
      }

      final List<dynamic> mapList = res.data?["companiesAndServices"] as List<dynamic>;
      final List<CompanyModel> list = mapList.map<CompanyModel>((e) => CompanyModel.fromJson(e as Map<String, dynamic>)).toList();

      return list;
    } on DioException catch (e) {
      if (e.response?.statusCode == 304 || e.type == DioExceptionType.connectionError) {
        final dataCache = await etagApiCacheService.getData(IsraelCompaniesServicesUrl);
        if (dataCache != null) {
          final List<dynamic> mapList = json.decode(utf8.decode(dataCache.toList()))["companiesAndServices"] as List<dynamic>;
          final List<CompanyModel> list = mapList.map<CompanyModel>((e) => CompanyModel.fromJson(e as Map<String, dynamic>)).toList();

          return list;
        }
      }

      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<File?> getLogo(url) async {
    try {
      final cacheEtag = await etagImageCacheService.getEtag(url);
      final res = await companiesRepository.getLogo(url: url, eTag: cacheEtag);

      if (res.statusCode == 200 && res.headers.value("etag") != null) {
        //Uint8List bytes = Uint8List.fromList(utf8.encode(res.data ?? ""));
        return etagImageCacheService.save(url, res.headers.value("etag")!, res.data);
      }

      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 304 || e.type == DioExceptionType.connectionError) {
        final dataCache = await etagImageCacheService.getDataFile(url);
        if (dataCache != null) {
          return dataCache;
        }
      }

      return null;
    } catch (e) {
      return null;
    }
    //res.data;
    //final res = await etagApiCacheService.getData(url);
    //if (res == null) {
    /*
      if (res.statusCode == 200 && res.headers.value("etag") != null) {
        Uint8List bytes = Uint8List.fromList(utf8.encode(res.data ?? ""));
        etagApiCacheService.save(IsraelCompaniesServicesUrl, res.headers.value("etag")!, bytes);
      }
      */
    //}
    //return res;
  }
}
