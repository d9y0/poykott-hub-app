import 'dart:io';

import 'package:boycott_hub/features/app_name/app_name_provider.dart';
import 'package:boycott_hub/features/app_prefix/app_prefix_provider.dart';
import 'package:boycott_hub/features/path_provider/path_provider.dart';

import 'package:boycott_hub/features/uuid/uuid_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

class EtagRepository {
  static final provider = Provider.family.autoDispose<EtagRepository, Tuple2<String, String>>((ref, p) {
    return EtagRepository(
      dirPath: path.join(ref.read(PathProvider.tempDirProvider).path, ref.read(appName), p.item1, p.item2),
      uuid: ref.read(UuidProvider.provider),
    );
  }, dependencies: [PathProvider.tempDirProvider, UuidProvider.provider, appName]);

  final String dirPath;
  final Uuid uuid;

  EtagRepository({
    required this.dirPath,
    required this.uuid,
  });

  Future<File> saveData(String url, Uint8List fileBytes) async {
    await removeData(url);

    final file = File(path.join(dirPath, '${uuid.v5(Uuid.NAMESPACE_URL, url)}_data.cache'));
    await file.create(recursive: true);

    //recursive: true
    return await file.writeAsBytes(fileBytes);
  }

  Future<Uint8List?> getData(String url) async {
    final file = File(path.join(dirPath, '${uuid.v5(Uuid.NAMESPACE_URL, url)}_data.cache'));
    final isExists = await file.exists();
    if (!isExists) {
      return null;
    }
    return await file.readAsBytes();
  }

  Future<File?> getFile(String url) async {
    final file = File(path.join(dirPath, '${uuid.v5(Uuid.NAMESPACE_URL, url)}_data.cache'));
    final isExists = await file.exists();
    if (!isExists) {
      return null;
    }
    return file;
  }

  Future<void> removeData(String url) async {
    final file = File(path.join(dirPath, '${uuid.v5(Uuid.NAMESPACE_URL, url)}_data.cache'));
    final isExists = await file.exists();
    if (isExists) {
      await file.delete();
    }
  }

  /// Etag

  Future<File> saveEtag(String url, String etag) async {
    await removeEtag(url);

    final file = File(path.join(dirPath, '${uuid.v5(Uuid.NAMESPACE_URL, url)}_etag.cache'));
    await file.create(recursive: true);
    return await file.writeAsString(etag);
  }

  Future<String?> getEtag(String url) async {
    final file = File(path.join(dirPath, '${uuid.v5(Uuid.NAMESPACE_URL, url)}_etag.cache'));
    final isExists = await file.exists();

    if (!isExists) {
      return null;
    }
    return await file.readAsString();
  }

  Future<void> removeEtag(String url) async {
    final file = File(path.join(dirPath, '${uuid.v5(Uuid.NAMESPACE_URL, url)}_etag.cache'));
    final isExists = await file.exists();
    if (isExists) {
      await file.delete();
    }
  }

  Future<void> remove(String url) async {
    await removeData(url);
    await removeEtag(url);
  }

  /// Genral
  removeAll() {
    final dir = Directory(dirPath);
    dir.deleteSync(recursive: true);
  }
}
