import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel();
  ThemeMode _themeMode = ThemeMode.system;
  int _quizHighScore = 0;
  bool _loaded = false;

  UserModel get user => _user;
  ThemeMode get themeMode => _themeMode;
  int get quizHighScore => _quizHighScore;
  bool get loaded => _loaded;

  // تحميل البيانات من التخزين المحلي
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    _user = UserModel(
      name: prefs.getString('user_name') ?? 'زائر',
      xp: prefs.getInt('user_xp') ?? 0,
      streak: prefs.getInt('user_streak') ?? 0,
      currentLevelIndex: prefs.getInt('user_level') ?? 0,
      learnedLetters: prefs.getStringList('user_learned_items') ?? [],
    );

    final bool? isDark = prefs.getBool('theme_dark');
    _themeMode = isDark == null
        ? ThemeMode.system
        : (isDark ? ThemeMode.dark : ThemeMode.light);

    _quizHighScore = prefs.getInt('quiz_high_score') ?? 0;

    // تحديث السلسلة اليومية بناءً على تاريخ آخر زيارة
    await _updateDailyStreak(prefs);

    _loaded = true;
    notifyListeners();
  }

  // حفظ البيانات
  Future<void> saveUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', _user.name);
    await prefs.setInt('user_xp', _user.xp);
    await prefs.setInt('user_streak', _user.streak);
    await prefs.setInt('user_level', _user.currentLevelIndex);
    await prefs.setStringList('user_learned_items', _user.learnedLetters);
  }

  // إضافة نقاط وترقية المستوى تلقائياً كل 500 نقطة
  void addXP(int points) {
    _user.xp += points;
    if (_user.xp >= 500 && _user.currentLevelIndex < 1) {
      _user.currentLevelIndex = 1;
    }
    if (_user.xp >= 1000 && _user.currentLevelIndex < 2) {
      _user.currentLevelIndex = 2;
    }
    if (_user.xp >= 2000 && _user.currentLevelIndex < 3) {
      _user.currentLevelIndex = 3;
    }
    if (_user.xp >= 4000 && _user.currentLevelIndex < 4) {
      _user.currentLevelIndex = 4;
    }
    saveUser();
    notifyListeners();
  }

  // تسجيل حرف/كلمة كمُتقَنة، مع مكافأة نقاط عند أول مرة فقط
  void markLearned(String itemId) {
    if (!_user.learnedLetters.contains(itemId)) {
      _user.learnedLetters.add(itemId);
      addXP(5);
    } else {
      saveUser();
      notifyListeners();
    }
  }

  bool isLearned(String itemId) => _user.learnedLetters.contains(itemId);

  void updateStreak(int newStreak) {
    _user.streak = newStreak;
    saveUser();
    notifyListeners();
  }

  void setUserName(String name) {
    if (name.trim().isEmpty) return;
    _user.name = name.trim();
    saveUser();
    notifyListeners();
  }

  // تبديل الوضع الليلي/النهاري وحفظ الاختيار
  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('theme_dark', _themeMode == ThemeMode.dark);
    notifyListeners();
  }

  Future<void> updateQuizScore(int score) async {
    if (score > _quizHighScore) {
      _quizHighScore = score;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('quiz_high_score', score);
      addXP(score * 2);
      notifyListeners();
    } else {
      addXP(score);
    }
  }

  Future<void> _updateDailyStreak(SharedPreferences prefs) async {
    final String today = DateTime.now().toIso8601String().substring(0, 10);
    final String? lastVisit = prefs.getString('last_visit_date');

    if (lastVisit == today) {
      return; // تمت الزيارة اليوم بالفعل
    }

    if (lastVisit != null) {
      final DateTime last = DateTime.parse(lastVisit);
      final DateTime now = DateTime.now();
      final int diff = DateTime(now.year, now.month, now.day)
          .difference(DateTime(last.year, last.month, last.day))
          .inDays;
      if (diff == 1) {
        _user.streak += 1; // زيارة يوم متتالٍ
      } else if (diff > 1) {
        _user.streak = 1; // انقطعت السلسلة وبدأت من جديد
      }
    } else {
      _user.streak = 1; // أول زيارة على الإطلاق
    }

    await prefs.setString('last_visit_date', today);
    await prefs.setInt('user_streak', _user.streak);
  }
}
