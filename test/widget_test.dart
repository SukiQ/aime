import 'package:aime/l10n/app_localizations.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en'); // 默认英文

  void _toggleLocale() {
    setState(() {
      _locale = _locale.languageCode == 'en'
          ? const Locale('zh')
          : const Locale('en');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomePage(onToggleLocale: _toggleLocale),
    );
  }
}

class HomePage extends StatefulWidget {
  final VoidCallback onToggleLocale;
  const HomePage({super.key, required this.onToggleLocale});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.model), // 多语言标题
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: widget.onToggleLocale,
          )
        ],
      ),
      body: Center(
        child: Text(
          _currentIndex == 0 ? l10n.model : l10n.model,
          style: const TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: l10n.model,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.school),
            label: l10n.model,
          ),
        ],
      ),
    );
  }
}
