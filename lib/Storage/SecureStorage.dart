import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Utils/Utils.dart';

class SecureStorage {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> saveUser(String userJson) async {
    await storage.write(key: Utils.secureStorageKeyUser, value: userJson);
  }

  Future<String?> getUser() async {
    return await storage.read(key: Utils.secureStorageKeyUser);
  }

  Future<void> clearUser() async {
    await storage.delete(key: Utils.secureStorageKeyUser);
  }
}
