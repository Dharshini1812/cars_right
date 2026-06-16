import 'package:cars_right/core/local_storage/hive_service.dart';

class LocalStorage {
  static Future<void> save(String key, dynamic value) async {
    await HiveService.box.put(key, value);
  }

  static T? get<T>(String key) {
    return HiveService.box.get(key);
  }

  static Future<void> remove(String key) async {
    await HiveService.box.delete(key);
  }

  static Future<void> clear() async {
    await HiveService.box.clear();
  }
}
