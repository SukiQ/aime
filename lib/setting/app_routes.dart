import 'package:aime/page/home.dart';
import 'package:aime/page/model/users/m_users.dart';
import 'package:aime/page/model/users/m_users_add.dart';
import 'package:aime/page/model/users/m_users_update.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String main = '/';
  static const String mUsers = '/model/users';
  static const String mUsersAdd = '/model/users/add';
  static const String mUsersEdit = '/model/users/edit';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.main:
        return MaterialPageRoute(builder: (_) => MainPage());
      case AppRoutes.mUsers:
        return MaterialPageRoute(builder: (context) => UsersPage());
      case AppRoutes.mUsersAdd:
        return MaterialPageRoute(builder: (context) => UsersAddPage());
      case AppRoutes.mUsersEdit:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => UsersUpdatePage(id: args['id']),
        );
      default:
        return MaterialPageRoute(builder: (_) => MainPage());
    }
  }
}
