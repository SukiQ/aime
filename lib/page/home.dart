
import 'package:aime/page/learn/learn.dart';
import 'package:aime/page/mall/mall.dart';
import 'package:aime/page/model/model.dart';
import 'package:aime/page/search/search.dart';
import 'package:aime/page/user/user.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});



  @override
  State<StatefulWidget> createState()=> _MainPage();
}

class _MainPage extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ModelPage(),
    LearnPage(),
    SearchPage(),
    MallPage(),
    UserPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("示例")),
      body: SafeArea( child: _pages[_currentIndex],),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(LucideIcons.codesandbox), label: '模型'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.libraryBig), label: '学习'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.search), label: '检索'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.shoppingCart), label: '商城'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: '我的'),
        ],
      ),
    );
  }
}