import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lesson_model.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';

/// لعبة اختبار سريع: تُعرض بطاقة عربية ويختار اللاعب النطق الصحيح
/// من بين 4 خيارات.
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<QuizQuestion> _questions;
  int _current = 0;
  int _score = 0;
  String? _selected;
  bool _answered = false;
  final int _totalQuestions = 10;

  @override
  void initState() {
    super.initState();
    _questions = _generateQuestions();
  }

  List<QuizQuestion> _generateQuestions() {
    final pool = List<FlashCardModel>.from(AppConstants.allCards)..shuffle();
    final selected = pool.take(_totalQuestions).toList();
    final random = Random();

    return selected.map((card) {
      final wrongPool = AppConstants.allCards
          .where((c) => c.id != card.id)
          .toList()
        ..shuffle(random);
      final wrongs = wrongPool.take(3).map((c) => c.transliteration).toList();
      final options = [card.transliteration, ...wrongs]..shuffle(random);
      return QuizQuestion(card: card, options: options, correctAnswer: card.transliteration);
    }).toList();
  }

  void _selectAnswer(String option) {
    if (_answered) return;
    setState(() {
      _selected = option;
      _answered = true;
      if (option == _questions[_current].correctAnswer) {
        _score++;
      }
    });
  }

  void _next() {
    if (_current < _questions.length - 1) {
      setState(() {
        _current++;
        _selected = null;
        _answered = false;
      });
    } else {
      context.read<UserProvider>().updateQuizScore(_score);
      _showResult();
    }
  }

  void _showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('🎉 انتهى الاختبار!'),
        content: Text('نتيجتك: $_score من ${_questions.length}\n\nحصلت على ${_score * 2} نقطة خبرة!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // إغلاق الحوار
              Navigator.pop(context); // العودة لشاشة الألعاب
            },
            child: const Text('العودة'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _questions = _generateQuestions();
                _current = 0;
                _score = 0;
                _selected = null;
                _answered = false;
              });
            },
            child: const Text('العب مجدداً'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_current];

    return Scaffold(
      appBar: AppBar(
        title: Text('اختبار سريع (${_current + 1}/${_questions.length})'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (_current + 1) / _questions.length,
              color: AppTheme.accentColor,
            ),
            const SizedBox(height: 30),
            Text('ما هو النطق الصحيح لهذه الكلمة؟', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(q.card.arabic, style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: q.options.map((option) {
                  Color? color;
                  if (_answered) {
                    if (option == q.correctAnswer) {
                      color = Colors.green;
                    } else if (option == _selected) {
                      color = Colors.red;
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: OutlinedButton(
                      onPressed: () => _selectAnswer(option),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: color?.withOpacity(0.15),
                        side: BorderSide(color: color ?? Colors.grey),
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Text(option, style: const TextStyle(fontSize: 16))),
                          if (_answered && option == q.correctAnswer)
                            const Icon(Icons.check_circle, color: Colors.green),
                          if (_answered && option == _selected && option != q.correctAnswer)
                            const Icon(Icons.cancel, color: Colors.red),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _answered ? _next : null,
                child: Text(_current == _questions.length - 1 ? 'إنهاء' : 'التالي'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
