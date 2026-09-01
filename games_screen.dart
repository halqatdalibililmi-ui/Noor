import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'quiz_screen.dart';
import 'match_game_screen.dart';
import 'coming_soon_screen.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final highScore = context.watch<UserProvider>().quizHighScore;

    return Scaffold(
      appBar: AppBar(title: const Text('الألعاب')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _GameTile(
            icon: Icons.quiz_rounded,
            color: Colors.indigo,
            title: 'اختبار سريع',
            subtitle: 'اختر النطق الصحيح • أفضل نتيجة: $highScore/10',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const QuizScreen()),
            ),
          ),
          _GameTile(
            icon: Icons.grid_view_rounded,
            color: Colors.teal,
            title: 'لعبة المطابقة',
            subtitle: 'طابق كل حرف مع نطقه الصحيح',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MatchGameScreen()),
            ),
          ),
          _GameTile(
            icon: Icons.route_rounded,
            color: Colors.deepOrange,
            title: 'متاهة الحروف',
            subtitle: 'قريباً',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ComingSoonScreen(
                  title: 'متاهة الحروف',
                  icon: Icons.route_rounded,
                ),
              ),
            ),
          ),
          _GameTile(
            icon: Icons.local_shipping_rounded,
            color: Colors.brown,
            title: 'لعبة التوصيل',
            subtitle: 'قريباً',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ComingSoonScreen(
                  title: 'لعبة التوصيل',
                  icon: Icons.local_shipping_rounded,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GameTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _GameTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
