import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';
import '../widgets/custom_drawer.dart';
import 'flashcard_screen.dart';
import 'library_screen.dart';
import 'learning_path_screen.dart';
import 'games_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;
    final xpIntoLevel = user.xp % 500;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية'),
        actions: [
          IconButton(
            tooltip: 'تبديل الوضع الليلي',
            icon: Icon(
              userProvider.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => userProvider.toggleTheme(),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة الترحيب
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.amber,
                      child: Icon(Icons.person, size: 35, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('مرحباً، ${user.name} 👋',
                              style: const TextStyle(fontSize: 20)),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 18),
                              Text(' ${user.xp} نقطة | '),
                              const Icon(Icons.local_fire_department,
                                  color: Colors.orange, size: 18),
                              Text(' ${user.streak} يوم'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        AppConstants.levels[user.currentLevelIndex],
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('تابع رحلتك 🚀',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: xpIntoLevel / 500,
              backgroundColor: Colors.grey[300],
              color: AppTheme.accentColor,
              minHeight: 10,
            ),
            const SizedBox(height: 8),
            Text('$xpIntoLevel / 500 نقطة للمستوى التالي',
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildQuickAction(context, Icons.school, 'التعلم', () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const LearningPathScreen()));
                }),
                _buildQuickAction(context, Icons.gamepad, 'الألعاب', () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const GamesScreen()));
                }),
                _buildQuickAction(context, Icons.mic, 'النطق', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardScreen(
                        title: 'تدريب النطق',
                        cards: AppConstants.arabicAlphabet,
                      ),
                    ),
                  );
                }),
                _buildQuickAction(context, Icons.library_books, 'المكتبة', () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const LibraryScreen()));
                }),
              ],
            ),
            const SizedBox(height: 20),
            const Text('أحدث الدروس 📖',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.abc, color: Colors.blue),
              title: const Text('الحروف الأبجدية'),
              subtitle: const Text('تعلم الحروف الـ 28 مع النطق'),
              trailing: const Icon(Icons.play_circle, color: Colors.green),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FlashcardScreen(
                      title: AppConstants.levels[0],
                      cards: AppConstants.arabicAlphabet,
                    ),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.chat, color: Colors.orange),
              title: const Text('التحية والتعارف'),
              subtitle: const Text('كيف تقدم نفسك بالعربية'),
              trailing: Icon(
                user.currentLevelIndex >= 1 ? Icons.play_circle : Icons.lock,
                color: user.currentLevelIndex >= 1 ? Colors.green : Colors.grey,
              ),
              onTap: () {
                if (user.currentLevelIndex >= 1) {
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('أكمل المستوى السابق لفتح هذا الدرس')),
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'التعلم'),
          BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: 'الألعاب'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف'),
        ],
        onTap: (index) {
          if (index == 1) Navigator.pushNamed(context, '/learning');
          else if (index == 2) Navigator.pushNamed(context, '/games');
          else if (index == 3) Navigator.pushNamed(context, '/profile');
        },
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: AppTheme.primaryColor),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
