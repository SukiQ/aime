import 'package:aime/cache/db/users.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    doTest(context);
    throw UnimplementedError();
  }

  Future<void> doTest(BuildContext context) async {
    UsersDao usersDao = await UsersDao.build(context);
    usersDao.add(
      Users(
        username: '花小琪',
        nickname: "戚小花",
        phone: '18706768036',
        birthday: DateTime.now(),
      ),
    );
  }
}
