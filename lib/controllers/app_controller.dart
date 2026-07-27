import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/focus_session.dart';
import '../services/local_storage_service.dart';

class AppController extends ChangeNotifier {
  AppController(this._storage);

  final LocalStorageService _storage;
  Timer? _timer;

  bool onboardingDone = false;
  bool darkMode = false;
  bool soundEnabled = true;
  bool hapticsEnabled = true;
  int coins = 0;
  int xp = 0;
  String selectedTree = 'Oak';
  List<FocusSession> sessions = [];

  int selectedMinutes = 25;
  int remainingSeconds = 25 * 60;
  bool running = false;
  bool paused = false;

  static const treeTypes = <String>[
    'Oak',
    'Pine',
    'Maple',
    'Cherry',
    'Palm',
    'Golden',
  ];

  Future<void> load() async {
    onboardingDone = _storage.onboardingDone;
    darkMode = _storage.darkMode;
    soundEnabled = _storage.soundEnabled;
    hapticsEnabled = _storage.hapticsEnabled;
    coins = _storage.coins;
    xp = _storage.xp;
    selectedTree = _storage.selectedTree;
    sessions = _storage.sessions;
    remainingSeconds = selectedMinutes * 60;
    notifyListeners();
  }

  int get level => (xp ~/ 100) + 1;
  int get totalMinutes =>
      sessions.fold<int>(0, (sum, session) => sum + session.minutes);

  int get todayMinutes {
    final now = DateTime.now();
    return sessions
        .where((s) =>
            s.completedAt.year == now.year &&
            s.completedAt.month == now.month &&
            s.completedAt.day == now.day)
        .fold<int>(0, (sum, s) => sum + s.minutes);
  }

  int get streak {
    if (sessions.isEmpty) return 0;
    final days = sessions
        .map((s) => DateTime(
              s.completedAt.year,
              s.completedAt.month,
              s.completedAt.day,
            ))
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));

    var count = 0;
    var cursor = DateTime.now();
    cursor = DateTime(cursor.year, cursor.month, cursor.day);

    if (!days.contains(cursor)) {
      cursor = cursor.subtract(const Duration(days: 1));
    }

    while (days.contains(cursor)) {
      count++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return count;
  }

  double get progress {
    final total = selectedMinutes * 60;
    if (total == 0) return 0;
    return 1 - (remainingSeconds / total);
  }

  void setDuration(int minutes) {
    if (running) return;
    selectedMinutes = minutes.clamp(5, 120);
    remainingSeconds = selectedMinutes * 60;
    notifyListeners();
  }

  void startTimer() {
    if (running && !paused) return;
    running = true;
    paused = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        notifyListeners();
      } else {
        _timer?.cancel();
        _completeSession();
      }
    });
    notifyListeners();
  }

  void pauseTimer() {
    if (!running) return;
    _timer?.cancel();
    paused = true;
    notifyListeners();
  }

  void resumeTimer() => startTimer();

  void resetTimer() {
    _timer?.cancel();
    running = false;
    paused = false;
    remainingSeconds = selectedMinutes * 60;
    notifyListeners();
  }

  Future<void> finishEarlyForTesting() async {
    _timer?.cancel();
    await _completeSession();
  }

  Future<void> _completeSession() async {
    running = false;
    paused = false;

    final session = FocusSession(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      minutes: selectedMinutes,
      completedAt: DateTime.now(),
      treeType: selectedTree,
    );

    sessions = [session, ...sessions];
    xp += selectedMinutes;
    coins += (selectedMinutes / 5).ceil();
    remainingSeconds = selectedMinutes * 60;

    await _storage.setSessions(sessions);
    await _storage.setXp(xp);
    await _storage.setCoins(coins);

    if (hapticsEnabled) {
      HapticFeedback.mediumImpact();
    }
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    onboardingDone = true;
    await _storage.setOnboardingDone(true);
    notifyListeners();
  }

  Future<void> selectTree(String value) async {
    selectedTree = value;
    await _storage.setSelectedTree(value);
    notifyListeners();
  }

  Future<void> toggleDarkMode(bool value) async {
    darkMode = value;
    await _storage.setDarkMode(value);
    notifyListeners();
  }

  Future<void> toggleSound(bool value) async {
    soundEnabled = value;
    await _storage.setSoundEnabled(value);
    notifyListeners();
  }

  Future<void> toggleHaptics(bool value) async {
    hapticsEnabled = value;
    await _storage.setHapticsEnabled(value);
    notifyListeners();
  }

  Future<void> resetAll() async {
    _timer?.cancel();
    await _storage.clear();
    onboardingDone = false;
    darkMode = false;
    soundEnabled = true;
    hapticsEnabled = true;
    coins = 0;
    xp = 0;
    selectedTree = 'Oak';
    sessions = [];
    selectedMinutes = 25;
    remainingSeconds = selectedMinutes * 60;
    running = false;
    paused = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
