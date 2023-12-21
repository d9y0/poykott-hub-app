import 'dart:io';

import 'package:boycott_hub/features/etag_management/repositories/etag_repository.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

class EtagManagementService {
  static final provider = Provider.family.autoDispose<EtagManagementService, Tuple2<String, String>>(
    (ref, p) => EtagManagementService(etagRepository: ref.read(EtagRepository.provider(p))),
    dependencies: [EtagRepository.provider],
  );

  final EtagRepository etagRepository;

  EtagManagementService({
    required this.etagRepository,
  });

  Future<String?> getEtag(String url) async {
    return await etagRepository.getEtag(url);
  }

  Future<Uint8List?> getData(String url) async {
    return await etagRepository.getData(url);
  }

  Future<File?> getDataFile(String url) async {
    return await etagRepository.getFile(url);
  }

  Future<File> save(String url, String etag, Uint8List fileBytes) async {
    await etagRepository.saveEtag(url, etag);
    return await etagRepository.saveData(url, fileBytes);
  }

  Future<void> remove(String url) async {
    await etagRepository.remove(url);
  }
}
