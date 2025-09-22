import 'package:aime/page/learning/learning.dart';
import 'package:aime/page/model/model.dart';
import 'package:aime/page/search/search.dart';
import 'package:aime/page/settings/settings.dart';
import 'package:aime/page/think/think.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../helper/screen.dart';
import '../l10n/app_localizations.dart';
import '../system/widget/divider.dart';

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
    const LearningPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (isWide) _buildNavigationRail(AppLocalizations.of(context)!),
            if (isWide) PageDivider(),
            Expanded(flex: 3, child: Center(child: _pages[_currentIndex])),
          ],
        ),
      ),
      bottomNavigationBar: isWide ? null : _buildBottomNavigationBar(l10n),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(AppLocalizations l10n) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          activeIcon: const Icon(LucideIcons.codesandbox400),
          icon: const Icon(LucideIcons.codesandbox300),
          label: l10n.model,
        ),
        BottomNavigationBarItem(
          activeIcon: const Icon(LucideIcons.lightbulb400),
          icon: const Icon(LucideIcons.lightbulb300),
          label: l10n.reasoning,
        ),
        BottomNavigationBarItem(
          activeIcon: const Icon(LucideIcons.search400),
          icon: Icon(LucideIcons.search300),
          label: l10n.search,
        ),
        BottomNavigationBarItem(
          activeIcon: const Icon(LucideIcons.libraryBig400),
          icon: Icon(LucideIcons.libraryBig300),
          label: l10n.learning,
        ),
        BottomNavigationBarItem(
          activeIcon: const Icon(LucideIcons.cog400),
          icon: Icon(LucideIcons.cog300),
          label: l10n.settings,
        ),
      ],
    );
  }

  NavigationRail _buildNavigationRail(AppLocalizations l10n) {
    return NavigationRail(
      groupAlignment: -0.8,
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
          padding: EdgeInsets.all(5),
        ),
        NavigationRailDestination(
          icon: const Icon(LucideIcons.lightbulb300),
          label: Text(l10n.reasoning),
          padding: EdgeInsets.all(5),
        ),
        NavigationRailDestination(
          icon: const Icon(LucideIcons.search300),
          label: Text(l10n.search),
          padding: EdgeInsets.all(5),
        ),
        NavigationRailDestination(
          icon: const Icon(LucideIcons.libraryBig300),
          label: Text(l10n.learning),
          padding: EdgeInsets.all(5),
        ),
        NavigationRailDestination(
          icon: const Icon(LucideIcons.cog300),
          label: Text(l10n.settings),
          padding: EdgeInsets.all(5),
        ),
      ],
    );
  }
}
