# 🌟 نور العربية - Noor Al-Arabiya

> تطبيق تفاعلي ممتع لتعلم اللغة العربية من الصفر حتى الإتقان، باستخدام اللغة الإنجليزية كجسر.

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Flutter](https://img.shields.io/badge/Flutter-3.0+-cyan)

## ✨ الميزات
- واجهة عربية كاملة (RTL) مع وضع ليلي حقيقي وقابل للتبديل.
- نظام تقدم ونقاط (XP)، وسلسلة يومية (Streak) تُحتسب تلقائياً حسب تاريخ آخر زيارة.
- **28 حرفاً عربياً** كاملاً كبطاقات تفاعلية، كل حرف مع مثال ونطق صوتي حقيقي.
- **12 كلمة أساسية** للتحية والمحادثة اليومية (المستوى الثاني).
- **نطق صوتي حقيقي** لكل حرف وكلمة عبر محرك تحويل النص إلى كلام في الجهاز (بدون إنترنت).
- **مكتبة بحث** لكل الحروف والكلمات مع تشغيل صوتي فوري.
- **لعبتان تفاعليتان بالكامل**: اختبار اختيار من متعدد، ولعبة مطابقة الحروف بنطقها.
- مسار تعلم من 5 مستويات يُفتح تلقائياً كلما ارتفع رصيد النقاط.
- حفظ كامل للتقدم محلياً عبر SharedPreferences (بدون خادم).

## 👨‍💻 المطور والمصمم والمنشئ
**Abdulmudallib Ismail Kaura**

## 🚀 كيفية التشغيل
1. تأكد من تثبيت Flutter SDK (نسخة 3.0 فأعلى).
2. من داخل مجلد المشروع:
   ```bash
   flutter pub get
   flutter run
   ```
3. لبناء نسخة APK جاهزة للتوزيع:
   ```bash
   flutter build apk --release
   ```

## 🗂️ هيكل المشروع
```
lib/
├── main.dart
├── models/
│   ├── user_model.dart
│   └── lesson_model.dart
├── providers/
│   └── user_provider.dart
├── screens/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── learning_path_screen.dart
│   ├── flashcard_screen.dart      # دروس الحروف والكلمات
│   ├── library_screen.dart        # المكتبة القابلة للبحث
│   ├── games_screen.dart          # مركز الألعاب
│   ├── quiz_screen.dart           # لعبة الاختبار السريع
│   ├── match_game_screen.dart     # لعبة المطابقة
│   ├── coming_soon_screen.dart
│   └── profile_screen.dart
├── widgets/
│   ├── custom_drawer.dart
│   └── lesson_card.dart
└── utils/
    ├── constants.dart   # بيانات الحروف والكلمات
    ├── theme.dart
    └── tts_helper.dart  # النطق الصوتي
```

## 🔜 خطوات مقترحة قادمة
- إضافة صورة/أيقونة رسمية للتطبيق في `assets/images/`.
- توسيع محتوى المستويات 3-5 (تكوين الجُمل، النحو، القراءة).
- إضافة لعبتي "متاهة الحروف" و"التوصيل".
