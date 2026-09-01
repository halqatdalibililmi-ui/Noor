/// نموذج بطاقة تعليمية موحّد يُستخدم لعرض الحروف والكلمات
/// في شاشات الدروس والألعاب والمكتبة.
class FlashCardModel {
  final String id; // معرّف فريد (نستخدم النص العربي نفسه غالباً)
  final String arabic; // الحرف أو الكلمة بالعربية
  final String transliteration; // النطق بالحروف اللاتينية
  final String meaning; // المعنى/الاسم بالإنجليزية
  final String? example; // كلمة مثال بالعربية (للحروف)
  final String? exampleTranslit; // نطق كلمة المثال
  final String? emoji; // رمز تعبيري مساعد للتذكر

  const FlashCardModel({
    required this.id,
    required this.arabic,
    required this.transliteration,
    required this.meaning,
    this.example,
    this.exampleTranslit,
    this.emoji,
  });
}

/// نموذج سؤال في لعبة الاختبار السريع
class QuizQuestion {
  final FlashCardModel card;
  final List<String> options; // 4 خيارات (واحد منها صحيح)
  final String correctAnswer;

  const QuizQuestion({
    required this.card,
    required this.options,
    required this.correctAnswer,
  });
}
