import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lesson_model.dart';
import '../providers/user_provider.dart';
import '../utils/theme.dart';
import '../utils/tts_helper.dart';

/// شاشة عرض البطاقات التعليمية (حروف أو كلمات) بشكل تفاعلي
/// مع إمكانية سماع النطق الصحيح لكل بطاقة.
class FlashcardScreen extends StatefulWidget {
  final String title;
  final List<FlashCardModel> cards;

  const FlashcardScreen({super.key, required this.title, required this.cards});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  late final PageController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    TtsHelper.stop();
    super.dispose();
  }

  void _markCurrentAsLearned() {
    final card = widget.cards[_index];
    context.read<UserProvider>().markLearned(card.id);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: LinearProgressIndicator(
            value: (_index + 1) / widget.cards.length,
            backgroundColor: Colors.white24,
            color: AppTheme.accentColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'البطاقة ${_index + 1} من ${widget.cards.length}',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.cards.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (context, i) {
                final card = widget.cards[i];
                final learned = userProvider.isLearned(card.id);
                return _CardView(card: card, learned: learned);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (_index > 0)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('السابق'),
                    ),
                  ),
                if (_index > 0) const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _markCurrentAsLearned();
                      if (_index < widget.cards.length - 1) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('🎉 أحسنت! أكملت هذا الدرس بالكامل')),
                        );
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(_index < widget.cards.length - 1
                        ? Icons.arrow_back
                        : Icons.check_circle),
                    label: Text(_index < widget.cards.length - 1 ? 'التالي (+5)' : 'إنهاء الدرس'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardView extends StatelessWidget {
  final FlashCardModel card;
  final bool learned;

  const _CardView({required this.card, required this.learned});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (learned)
                const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(Icons.check_circle, color: Colors.green, size: 28),
                ),
              if (card.emoji != null)
                Text(card.emoji!, style: const TextStyle(fontSize: 40)),
              const SizedBox(height: 12),
              Text(
                card.arabic,
                style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                card.transliteration,
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                card.meaning,
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 24),
              IconButton.filled(
                iconSize: 32,
                padding: const EdgeInsets.all(16),
                icon: const Icon(Icons.volume_up),
                onPressed: () => TtsHelper.speak(card.arabic),
              ),
              const SizedBox(height: 8),
              const Text('اضغط للاستماع إلى النطق', style: TextStyle(fontSize: 12)),
              if (card.example != null) ...[
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(card.example!, style: const TextStyle(fontSize: 22)),
                    IconButton(
                      icon: const Icon(Icons.volume_up, size: 20),
                      onPressed: () => TtsHelper.speak(card.example!),
                    ),
                  ],
                ),
                if (card.exampleTranslit != null)
                  Text(card.exampleTranslit!, style: TextStyle(color: Colors.grey[600])),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
