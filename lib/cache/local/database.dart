import 'package:cbl/cbl.dart';
import 'package:flutter/material.dart';

class LocalDatabase extends ChangeNotifier {
  late Future<Database> _locale;

  Future<Database> get locale => _locale;

  LocalDatabase() {
    _load();
  }

  void _load() {
    _locale = Database.openAsync('aime');
  }
}
