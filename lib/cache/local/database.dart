import 'package:cbl/cbl.dart';
import 'package:flutter/material.dart';

class LocalDatabase extends ChangeNotifier {
  late Database _locale;

  Database get locale => _locale;

  LocalDatabase() {
    _loadLocalDatabase();
  }

  Future<void> _loadLocalDatabase() async {
    _locale = await Database.openAsync('aime');
  }
}
