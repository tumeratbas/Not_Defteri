import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'themes.dart';
import 'screens/home_screen.dart';
import 'screens/notes_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/note_detail_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart'; // Eklenmesi gereken satır

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme') ?? 'light';
    setState(() {
      _themeMode = theme == 'light' ? ThemeMode.light : ThemeMode.dark;
    });
  }

  Future<void> _toggleThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isLightMode = _themeMode == ThemeMode.light;
    setState(() {
      _themeMode = isLightMode ? ThemeMode.dark : ThemeMode.light;
    });
    prefs.setString('theme', isLightMode ? 'dark' : 'light');
  }

  final GoRouter _router = GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Not Defteri'),
              actions: [
                IconButton(
                  icon: Icon(Icons.brightness_6),
                  onPressed: () {
                    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
                    state._toggleThemeMode();
                  },
                ),
              ],
            ),
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _calculateSelectedIndex(state.uri.toString()),
              onTap: (index) => _onItemTapped(context, index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.note),
                  label: 'Notes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => HomeScreen(),
          ),
          GoRoute(
            path: '/notes',
            builder: (context, state) => NotesScreen(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final noteId = int.parse(state.pathParameters['id']!);
                  return NoteDetailScreen(noteId: noteId);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => SettingsScreen(),
          ),
        ],
      ),
    ],
  );

  static int _calculateSelectedIndex(String location) {
    if (location.startsWith('/notes')) {
      return 1;
    }
    if (location.startsWith('/settings')) {
      return 2;
    }
    return 0;
  }

  static void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/notes');
        break;
      case 2:
        context.go('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Locale overriddenLocale = const Locale('en', 'US');
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      supportedLocales: [
        const Locale('en', 'US'), // İngilizce
        const Locale('tr', 'TR'), // Türkçe
      ],
      localizationsDelegates: [
        AppLocalizationsDelegate(overriddenLocale: overriddenLocale),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
