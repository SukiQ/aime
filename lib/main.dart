import 'package:aime/common/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('zh', 'CN'),
      title: 'Aime',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.background,
        ),
        scaffoldBackgroundColor: AppColors.background,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.background,
        ),
        navigationDrawerTheme: NavigationDrawerThemeData(
          backgroundColor: AppColors.background,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.primary,
        )
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: SafeArea(child: Center(child: Text("Hello World"))),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: '搜索'),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
