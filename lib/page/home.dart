import 'package:aime/page/learning/learning.dart';
import 'package:aime/page/model/model.dart';
import 'package:aime/page/search/search.dart';
import 'package:aime/page/settings/settings.dart';
import 'package:aime/page/think/think.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../helper/screen_helper.dart';
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
    final isWide = ScreenHelper.isWide(context);

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (isWide)
              NavigationRail(
                selectedIndex: _currentIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                destinations: [
                  NavigationRailDestination(
                    icon: const Icon(LucideIcons.codesandbox300),
                    label: Text(l10n.model),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(LucideIcons.lightbulb300),
                    label: Text(l10n.think),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(LucideIcons.search300),
                    label: Text(l10n.search),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(LucideIcons.libraryBig300),
                    label: Text(l10n.learning),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(LucideIcons.cog300),
                    label: Text(l10n.settings),
                  ),
                ],
              ),
            Expanded(child: Center(child: _pages[_currentIndex])),
          ],
        ),
      ),
      bottomNavigationBar: isWide
          ? null
          : BottomNavigationBar(
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
