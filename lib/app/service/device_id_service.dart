import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceIdService {
  static const _prefsKey = 'device_id';
  static const _uuid = Uuid();

  /// Returns the persisted device UUID, generating and saving one on first use.
  Future<String> getOrCreateDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_prefsKey);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }
    final id = _uuid.v4();
    await prefs.setString(_prefsKey, id);
    return id;
  }
}

final DeviceIdService deviceIdService = DeviceIdService();
