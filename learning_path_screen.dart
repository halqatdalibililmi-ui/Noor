import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../widgets/lesson_card.dart';
import 'flashcard_screen.dart';
import 'coming_soon_screen.dart';

class LearningPathScreen extends StatelessWidget {
  const LearningPathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final userLevel = userProvider.user.currentLevelIndex;

    return Scaffold(
      appBar: AppBar(title: const Text('مسار التعلم')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: List.generate(AppConstants.levels.length, (index) {
          final bool isUnlocked = index <= userLevel;
          final int learnedCount = index == 0
              ? AppConstants.arabicAlphabet.where((c) => userProvider.isLearned(c.id)).length
              : index == 1
                  ? AppConstants.basicWords.where((c) => userProvider.isLearned(c.id)).length
                  : 0;
          final int totalCount = index == 0
              ? AppConstants.arabicAlphabet.length
              : index == 1
                  ? AppConstants.basicWords.length
                  : 0;

          String subtitle;
          if (!isUnlocked) {
            subtitle = '🔒 أكمل المستوى السابق أولاً';
          } else if (totalCount > 0) {
            subtitle = '${AppConstants.levelDescriptions[index]} • $learnedCount/$totalCount';
          } else {
            subtitle = AppConstants.levelDescriptions[index];
          }

          return LessonCard(
            title: AppConstants.levels[index],
            subtitle: subtitle,
            icon: isUnlocked ? Icons.menu_book_rounded : Icons.lock_outline,
            isCompleted: totalCount > 0 && learnedCount == totalCount,
            onTap: () {
              if (!isUnlocked) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('هذا المستوى مقفل حالياً. تابع التعلم لفتحه!')),
                );
                return;
              }
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FlashcardScreen(
                      title: AppConstants.levels[0],
                      cards: AppConstants.arabicAlphabet,
                    ),
                  ),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FlashcardScreen(
                      title: AppConstants.levels[1],
                      cards: AppConstants.basicWords,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ComingSoonScreen(
                      title: AppConstants.levels[index],
                      message: 'محتوى "${AppConstants.levels[index]}" قيد الإعداد حالياً.',
                    ),
                  ),
                );
              }
            },
          );
        }),
      ),
    );
  }
}
