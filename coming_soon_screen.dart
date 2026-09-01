import 'package:flutter/material.dart';
import '../utils/theme.dart';

/// شاشة عامة تُستخدم لأي محتوى لم يكتمل بعد، بدل رسائل Snackbar المؤقتة.
class ComingSoonScreen extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const ComingSoonScreen({
    super.key,
    required this.title,
    this.message = 'نعمل بجدّ على إضافة هذا المحتوى قريباً. تابعونا!',
    this.icon = Icons.hourglass_top_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 80, color: AppTheme.accentColor),
              const SizedBox(height: 20),
              const Text('🚧 قريباً جداً!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('العودة'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
