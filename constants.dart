import '../models/lesson_model.dart';

class AppConstants {
  static const String appName = 'نور العربية';
  static const String developerName = 'Abdulmudallib Ismail Kaura';

  // المستويات
  static const List<String> levels = [
    'مبتدئ (Beginner)',
    'مبتدئ متقدم (Upper Beginner)',
    'متوسط (Intermediate)',
    'متقدم (Advanced)',
    'خبير (Expert)',
  ];

  // وصف كل مستوى لعرضه في مسار التعلم
  static const List<String> levelDescriptions = [
    'الحروف الهجائية الـ 28 مع النطق الصحيح',
    'كلمات وتحيات أساسية للحياة اليومية',
    'تكوين الجُمل البسيطة والمحادثة',
    'قواعد النحو وإثراء المفردات',
    'إتقان القراءة والكتابة والفصاحة',
  ];

  // الحروف الأبجدية العربية الـ 28 مع أمثلة
  static const List<FlashCardModel> arabicAlphabet = [
    FlashCardModel(id: 'alif', arabic: 'ا', transliteration: 'Alif', meaning: 'A', example: 'أَسَد', exampleTranslit: 'Asad (Lion)', emoji: '🦁'),
    FlashCardModel(id: 'baa', arabic: 'ب', transliteration: 'Baa', meaning: 'B', example: 'بَاب', exampleTranslit: 'Baab (Door)', emoji: '🚪'),
    FlashCardModel(id: 'taa', arabic: 'ت', transliteration: 'Taa', meaning: 'T', example: 'تُفَّاح', exampleTranslit: 'Tuffah (Apple)', emoji: '🍎'),
    FlashCardModel(id: 'thaa', arabic: 'ث', transliteration: 'Thaa', meaning: 'Th', example: 'ثَعْلَب', exampleTranslit: "Tha'lab (Fox)", emoji: '🦊'),
    FlashCardModel(id: 'jeem', arabic: 'ج', transliteration: 'Jeem', meaning: 'J', example: 'جَمَل', exampleTranslit: 'Jamal (Camel)', emoji: '🐫'),
    FlashCardModel(id: 'haa1', arabic: 'ح', transliteration: 'Haa', meaning: 'H (heavy)', example: 'حِصَان', exampleTranslit: 'Hisan (Horse)', emoji: '🐴'),
    FlashCardModel(id: 'khaa', arabic: 'خ', transliteration: 'Khaa', meaning: 'Kh', example: 'خُبْز', exampleTranslit: 'Khubz (Bread)', emoji: '🍞'),
    FlashCardModel(id: 'dal', arabic: 'د', transliteration: 'Dal', meaning: 'D', example: 'دُبّ', exampleTranslit: 'Dubb (Bear)', emoji: '🐻'),
    FlashCardModel(id: 'dhal', arabic: 'ذ', transliteration: 'Dhal', meaning: 'Dh', example: 'ذِئْب', exampleTranslit: "Thi'b (Wolf)", emoji: '🐺'),
    FlashCardModel(id: 'raa', arabic: 'ر', transliteration: 'Raa', meaning: 'R', example: 'رُمَّان', exampleTranslit: 'Rumman (Pomegranate)', emoji: '🍎'),
    FlashCardModel(id: 'zay', arabic: 'ز', transliteration: 'Zay', meaning: 'Z', example: 'زَرَافَة', exampleTranslit: 'Zarafa (Giraffe)', emoji: '🦒'),
    FlashCardModel(id: 'seen', arabic: 'س', transliteration: 'Seen', meaning: 'S', example: 'سَمَكَة', exampleTranslit: 'Samaka (Fish)', emoji: '🐟'),
    FlashCardModel(id: 'sheen', arabic: 'ش', transliteration: 'Sheen', meaning: 'Sh', example: 'شَمْس', exampleTranslit: 'Shams (Sun)', emoji: '☀️'),
    FlashCardModel(id: 'sad', arabic: 'ص', transliteration: 'Sad', meaning: 'S (heavy)', example: 'صَقْر', exampleTranslit: 'Saqr (Falcon)', emoji: '🦅'),
    FlashCardModel(id: 'dad', arabic: 'ض', transliteration: 'Dad', meaning: 'D (heavy)', example: 'ضِفْدَع', exampleTranslit: "Difda' (Frog)", emoji: '🐸'),
    FlashCardModel(id: 'taa2', arabic: 'ط', transliteration: 'Taa (heavy)', meaning: 'T (heavy)', example: 'طَائِر', exampleTranslit: "Ta'ir (Bird)", emoji: '🐦'),
    FlashCardModel(id: 'zaa', arabic: 'ظ', transliteration: 'Zaa', meaning: 'Z (heavy)', example: 'ظَبْي', exampleTranslit: 'Zabi (Gazelle)', emoji: '🦌'),
    FlashCardModel(id: 'ayn', arabic: 'ع', transliteration: 'Ayn', meaning: "'Ayn", example: 'عَيْن', exampleTranslit: "Ayn (Eye)", emoji: '👁️'),
    FlashCardModel(id: 'ghayn', arabic: 'غ', transliteration: 'Ghayn', meaning: 'Gh', example: 'غَزَال', exampleTranslit: 'Ghazal (Deer)', emoji: '🦌'),
    FlashCardModel(id: 'faa', arabic: 'ف', transliteration: 'Faa', meaning: 'F', example: 'فِيل', exampleTranslit: 'Feel (Elephant)', emoji: '🐘'),
    FlashCardModel(id: 'qaf', arabic: 'ق', transliteration: 'Qaf', meaning: 'Q', example: 'قَمَر', exampleTranslit: 'Qamar (Moon)', emoji: '🌙'),
    FlashCardModel(id: 'kaf', arabic: 'ك', transliteration: 'Kaf', meaning: 'K', example: 'كِتَاب', exampleTranslit: 'Kitab (Book)', emoji: '📖'),
    FlashCardModel(id: 'lam', arabic: 'ل', transliteration: 'Lam', meaning: 'L', example: 'لَيْمُون', exampleTranslit: 'Laymun (Lemon)', emoji: '🍋'),
    FlashCardModel(id: 'meem', arabic: 'م', transliteration: 'Meem', meaning: 'M', example: 'مَوْز', exampleTranslit: 'Mawz (Banana)', emoji: '🍌'),
    FlashCardModel(id: 'noon', arabic: 'ن', transliteration: 'Noon', meaning: 'N', example: 'نَجْمَة', exampleTranslit: 'Najma (Star)', emoji: '⭐'),
    FlashCardModel(id: 'haa2', arabic: 'ه', transliteration: 'Haa', meaning: 'H (light)', example: 'هِلَال', exampleTranslit: 'Hilal (Crescent)', emoji: '🌙'),
    FlashCardModel(id: 'waw', arabic: 'و', transliteration: 'Waw', meaning: 'W', example: 'وَرْدَة', exampleTranslit: 'Warda (Rose)', emoji: '🌹'),
    FlashCardModel(id: 'yaa', arabic: 'ي', transliteration: 'Yaa', meaning: 'Y', example: 'يَد', exampleTranslit: 'Yad (Hand)', emoji: '✋'),
  ];

  // كلمات وتحيات أساسية (المستوى الثاني)
  static const List<FlashCardModel> basicWords = [
    FlashCardModel(id: 'marhaban', arabic: 'مَرْحَباً', transliteration: 'Marhaban', meaning: 'Hello', emoji: '👋'),
    FlashCardModel(id: 'shukran', arabic: 'شُكْراً', transliteration: 'Shukran', meaning: 'Thank you', emoji: '🙏'),
    FlashCardModel(id: 'naam', arabic: 'نَعَم', transliteration: "Na'am", meaning: 'Yes', emoji: '✅'),
    FlashCardModel(id: 'la', arabic: 'لَا', transliteration: 'La', meaning: 'No', emoji: '❌'),
    FlashCardModel(id: 'maa', arabic: 'مَاء', transliteration: "Ma'", meaning: 'Water', emoji: '💧'),
    FlashCardModel(id: 'bayt', arabic: 'بَيْت', transliteration: 'Bayt', meaning: 'House', emoji: '🏠'),
    FlashCardModel(id: 'qalam', arabic: 'قَلَم', transliteration: 'Qalam', meaning: 'Pen', emoji: '✏️'),
    FlashCardModel(id: 'madrasa', arabic: 'مَدْرَسَة', transliteration: 'Madrasa', meaning: 'School', emoji: '🏫'),
    FlashCardModel(id: 'sadiq', arabic: 'صَدِيق', transliteration: 'Sadiq', meaning: 'Friend', emoji: '🤝'),
    FlashCardModel(id: 'salam', arabic: 'سَلَام', transliteration: 'Salam', meaning: 'Peace', emoji: '☮️'),
    FlashCardModel(id: 'jameel', arabic: 'جَمِيل', transliteration: 'Jameel', meaning: 'Beautiful', emoji: '✨'),
    FlashCardModel(id: 'kabeer', arabic: 'كَبِير', transliteration: 'Kabeer', meaning: 'Big', emoji: '📏'),
  ];

  static List<FlashCardModel> get allCards => [...arabicAlphabet, ...basicWords];
}
