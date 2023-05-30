import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AppSharedPref extends GetxService {
  late FlutterSecureStorage secureStorage;

  /// initialize the shared pref object.
  init() {
    secureStorage = const FlutterSecureStorage();
    return this;
  }

  /// for setting string values in the storage.
  putStringValue({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }

  /// for getting string values from the storage.
  Future<String?> getStringValue({required String key}) async {
    String? value = await secureStorage.read(key: key);
    return value;
  }
  deleteValue({required String key}) async {
     await secureStorage.delete(key: key);
  }
}
