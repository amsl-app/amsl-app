import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'storages.g.dart';

class Storages {
  SharedPreferences shared;
  FlutterSecureStorage secure;

  Storages({required this.shared, required this.secure});
}

@Riverpod(keepAlive: true, dependencies: [])
Storages storages(Ref ref) {
  throw UnimplementedError();
}
