import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/focus_session.dart';

class LocalStorageService {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get onboardingDone => _prefs.getBool('onboarding_done') ?? false;
  bool get darkMode => _prefs.getBool('dark_mode') ?? false;
  bool get soundEnabled => _prefs.getBool('sound_enabled') ?? true;
  bool get hapticsEnabled => _prefs.getBool('haptics_enabled') ?? true;
  int get coins => _prefs.getInt('coins') ?? 0;
  int get xp => _prefs.getInt('xp') ?? 0;
  String get selectedTree => _prefs.getString('selected_tree') ?? 'Oak';

  List<FocusSession> get sessions {
    final raw = _prefs.getStringList('sessions') ?? const [];
    return raw.map((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return FocusSession.fromJson(map);
    }).toList();
  }

  Future<void> setOnboardingDone(bool value) =>
      _prefs.setBool('onboarding_done', value);

  Future<void> setDarkMode(bool value) =>
      _prefs.setBool('dark_mode', value);

  Future<void> setSoundEnabled(bool value) =>
      _prefs.setBool('sound_enabled', value);

  Future<void> setHapticsEnabled(bool value) =>
      _prefs.setBool('haptics_enabled', value);

  Future<void> setCoins(int value) => _prefs.setInt('coins', value);
  Future<void> setXp(int value) => _prefs.setInt('xp', value);

  Future<void> setSelectedTree(String value) =>
      _prefs.setString('selected_tree', value);

  Future<void> setSessions(List<FocusSession> value) {
    return _prefs.setStringList(
      'sessions',
      value.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
