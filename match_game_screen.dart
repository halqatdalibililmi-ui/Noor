import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lesson_model.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';

class _MatchTile {
  final String id; // معرف البطاقة الأصلية (لمطابقة الزوج)
  final String label; // النص المعروض (عربي أو نطق)
  bool matched = false;

  _MatchTile({required this.id, required this.label});
}

/// لعبة المطابقة: يختار اللاعب حرفاً عربياً ثم نطقه الصحيح لتشكيل زوج.
class MatchGameScreen extends StatefulWidget {
  const MatchGameScreen({super.key});

  @override
  State<MatchGameScreen> createState() => _MatchGameScreenState();
}

class _MatchGameScreenState extends State<MatchGameScreen> {
  static const int _pairCount = 6;
  late List<_MatchTile> _tiles;
  int? _firstIndex;
  int _moves = 0;
  int _matchedPairs = 0;
  bool _busy = false;
  Stopwatch _stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    _setup();
    _stopwatch.start();
  }

  void _setup() {
    final pool = List<FlashCardModel>.from(AppConstants.arabicAlphabet)..shuffle();
    final chosen = pool.take(_pairCount).toList();
    final tiles = <_MatchTile>[];
    for (final c in chosen) {
      tiles.add(_MatchTile(id: c.id, label: c.arabic));
      tiles.add(_MatchTile(id: c.id, label: c.transliteration));
    }
    tiles.shuffle();
    _tiles = tiles;
  }

  void _onTap(int index) {
    if (_busy || _tiles[index].matched || index == _firstIndex) return;

    setState(() {
      if (_firstIndex == null) {
        _firstIndex = index;
      } else {
        _moves++;
        final a = _tiles[_firstIndex!];
        final b = _tiles[index];
        if (a.id == b.id) {
          a.matched = true;
          b.matched = true;
          _matchedPairs++;
          _firstIndex = null;
          if (_matchedPairs == _pairCount) {
            _finish();
          }
        } else {
          _busy = true;
          final wrongFirst = _firstIndex!;
          final wrongSecond = index;
          Timer(const Duration(milliseconds: 650), () {
            if (!mounted) return;
            setState(() {
              _busy = false;
              _firstIndex = null;
            });
          });
          // نُبقي المؤشرات كي تُعرض حمراء لحظياً عبر _selectedIndexes
          _wrongPair = [wrongFirst, wrongSecond];
        }
      }
    });
  }

  List<int> _wrongPair = [];

  void _finish() {
    _stopwatch.stop();
    final seconds = _stopwatch.elapsed.inSeconds;
    final xp = (_pairCount * 8 - _moves).clamp(10, 100);
    context.read<UserProvider>().addXP(xp);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('🏆 أحسنت!'),
        content: Text('أكملت اللعبة في $_moves محاولة و$seconds ثانية.\nحصلت على $xp نقطة خبرة!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('العودة'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _setup();
                _firstIndex = null;
                _moves = 0;
                _matchedPairs = 0;
                _busy = false;
                _stopwatch = Stopwatch()..start();
              });
            },
            child: const Text('العب مجدداً'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لعبة المطابقة')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('المحاولات: $_moves'),
                Text('الأزواج: $_matchedPairs/$_pairCount'),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: _tiles.length,
              itemBuilder: (context, i) {
                final tile = _tiles[i];
                final bool isSelected = i == _firstIndex;
                final bool isWrong = _wrongPair.contains(i) && _busy;

                Color bg;
                if (tile.matched) {
                  bg = Colors.green.withOpacity(0.25);
                } else if (isWrong) {
                  bg = Colors.red.withOpacity(0.25);
                } else if (isSelected) {
                  bg = AppTheme.accentColor.withOpacity(0.3);
                } else {
                  bg = Theme.of(context).cardColor;
                }

                return GestureDetector(
                  onTap: () => _onTap(i),
                  child: Container(
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: tile.matched ? Colors.green : Colors.grey.withOpacity(0.4),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      tile.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: tile.matched ? Colors.green[800] : null,
                      ),
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
