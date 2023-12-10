import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class PathProvider {
  static Future<Directory Function(ProviderRef<Directory>)> Function() tempDirProviderRefFn = () async {
    var temporaryDir = await getTemporaryDirectory();

    return (ref) {
      return temporaryDir;
    };
  };

  static final tempDirProvider = Provider<Directory>((ref) => throw UnimplementedError());

  //var cacheDir = await getTemporaryDirectory();
}



/**
 * static Future<DioService Function(ProviderRef<DioService>)> Function() providerRefFn = () async {
    final service = DioService();

    await service._initializeDio();
    return (ref) {
      return service;
    };
  };
  static Provider<DioService> provider = Provider<DioService>((ref) => throw UnimplementedError());
 */