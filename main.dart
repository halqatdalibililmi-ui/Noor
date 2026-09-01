import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'utils/theme.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/learning_path_screen.dart';
import 'screens/games_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/library_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..loadUser()),
      ],
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          return MaterialApp(
            title: 'نور العربية',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: userProvider.themeMode,
            // الواجهة بأكملها من اليمين إلى اليسار لدعم العربية بشكل كامل
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child ?? const SizedBox.shrink(),
              );
            },
            initialRoute: '/splash',
            routes: {
              '/splash': (context) => const SplashScreen(),
              '/home': (context) => const HomeScreen(),
              '/learning': (context) => const LearningPathScreen(),
              '/games': (context) => const GamesScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/library': (context) => const LibraryScreen(),
            },
          );
        },
      ),
    );
  }
}
