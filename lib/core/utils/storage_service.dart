import 'package:get_storage/get_storage.dart';

class StorageService {
  static final box = GetStorage();

  static Future<void> saveToken(String token) async =>
      await box.write("token", token);

  static String? getToken() => box.read("token");

  static Future<void> clearToken() async => await box.remove("token");
}
