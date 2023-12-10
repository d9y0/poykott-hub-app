import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class UuidProvider {
  static final provider = Provider((ref) => const Uuid());
}
