class UserModel {
  String name;
  int xp;
  int streak;
  int currentLevelIndex; // 0 إلى 4
  List<String> learnedLetters; // الحروف/الكلمات التي أتقنها المستخدم

  UserModel({
    this.name = 'زائر',
    this.xp = 0,
    this.streak = 0,
    this.currentLevelIndex = 0,
    List<String>? learnedLetters,
  }) : learnedLetters = learnedLetters ?? [];

  Map<String, dynamic> toJson() => {
        'name': name,
        'xp': xp,
        'streak': streak,
        'currentLevelIndex': currentLevelIndex,
        'learnedLetters': learnedLetters,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'] ?? 'زائر',
        xp: json['xp'] ?? 0,
        streak: json['streak'] ?? 0,
        currentLevelIndex: json['currentLevelIndex'] ?? 0,
        learnedLetters: (json['learnedLetters'] as List?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
      );
}
