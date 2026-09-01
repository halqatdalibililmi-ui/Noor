import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _editName(BuildContext context, UserProvider provider) {
    final controller = TextEditingController(text: provider.user.name);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تعديل الاسم'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'أدخل اسمك'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              provider.setUserName(controller.text);
              Navigator.pop(context);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;
    final letterProgress =
        AppConstants.arabicAlphabet.where((c) => userProvider.isLearned(c.id)).length;

    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(radius: 60, child: Icon(Icons.person, size: 60)),
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                Text(user.name, style: const TextStyle(fontSize: 24)),
                TextButton.icon(
                  onPressed: () => _editName(context, userProvider),
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('تعديل الاسم'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(child: Chip(label: Text(AppConstants.levels[user.currentLevelIndex]))),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: const Icon(Icons.star, color: Colors.amber),
              title: const Text('النقاط'),
              trailing: Text('${user.xp} XP', style: const TextStyle(fontSize: 18)),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.local_fire_department, color: Colors.orange),
              title: const Text('سلسلة التعلم'),
              trailing: Text('${user.streak} يوم', style: const TextStyle(fontSize: 18)),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.abc, color: Colors.blue),
              title: const Text('الحروف المتقنة'),
              trailing: Text('$letterProgress / ${AppConstants.arabicAlphabet.length}',
                  style: const TextStyle(fontSize: 18)),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.quiz, color: Colors.indigo),
              title: const Text('أفضل نتيجة في الاختبار'),
              trailing: Text('${userProvider.quizHighScore} / 10',
                  style: const TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(
              userProvider.themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
              color: AppTheme.primaryColor,
            ),
            title: const Text('الوضع الليلي'),
            trailing: Switch(
              value: userProvider.themeMode == ThemeMode.dark,
              onChanged: (_) => userProvider.toggleTheme(),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          Center(
            child: Column(
              children: [
                Text('تم التطوير بواسطة', style: TextStyle(color: Colors.grey[600])),
                Text(AppConstants.developerName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
