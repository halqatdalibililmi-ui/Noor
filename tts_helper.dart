import 'package:flutter_tts/flutter_tts.dart';

/// أداة مساعدة لنطق الحروف والكلمات العربية عبر محرك تحويل النص إلى صوت
/// المدمج في الجهاز (يعمل دون الحاجة إلى اتصال بالإنترنت في أغلب الأجهزة).
class TtsHelper {
  static final FlutterTts _tts = FlutterTts();
  static bool _initialized = false;

  static Future<void> _init() async {
    if (_initialized) return;
    await _tts.setLanguage('ar-SA');
    await _tts.setSpeechRate(0.42);
    await _tts.setPitch(1.0);
    _initialized = true;
  }

  static Future<void> speak(String text) async {
    await _init();
    await _tts.stop();
    await _tts.speak(text);
  }

  static Future<void> stop() => _tts.stop();
}
