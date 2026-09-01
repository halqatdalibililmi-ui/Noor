import 'package:flutter/material.dart';
import '../models/lesson_model.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';
import '../utils/tts_helper.dart';

/// مكتبة تحتوي على جميع الحروف والكلمات مع إمكانية البحث والاستماع.
class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final List<FlashCardModel> all = AppConstants.allCards;
    final List<FlashCardModel> filtered = _query.isEmpty
        ? all
        : all
            .where((c) =>
                c.arabic.contains(_query) ||
                c.transliteration.toLowerCase().contains(_query.toLowerCase()) ||
                c.meaning.toLowerCase().contains(_query.toLowerCase()))
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('المكتبة')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'ابحث عن حرف أو كلمة...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text('لا توجد نتائج', style: TextStyle(color: Colors.grey[600])),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: filtered.length,
                    itemBuilder: (context, i) {
                      final card = filtered[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppTheme.primaryColor,
                            child: Text(
                              card.emoji ?? card.arabic,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          title: Text(card.arabic, style: const TextStyle(fontSize: 20)),
                          subtitle: Text('${card.transliteration} • ${card.meaning}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.volume_up),
                            color: AppTheme.primaryColor,
                            onPressed: () => TtsHelper.speak(card.arabic),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
