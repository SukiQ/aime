import 'package:aime/page/learning/learning.dart';
import 'package:aime/page/model/model.dart';
import 'package:aime/page/search/search.dart';
import 'package:aime/page/settings/settings.dart';
import 'package:aime/page/think/think.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../l10n/app_localizations.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ModelPage(),
    const ThinkPage(),
    const SearchPage(),
    LearningPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(LucideIcons.codesandbox300),
            label: l10n.model,
          ),
          BottomNavigationBarItem(
            icon: const Icon(LucideIcons.lightbulb300),
            label: l10n.think,
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.search300),
            label: l10n.search,
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.libraryBig300),
            label: l10n.learning,
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.cog300),
            label: l10n.settings,
          ),
        ],
      ),
    );
  }
}
