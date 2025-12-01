import 'dart:ui';

import 'package:flutter/material.dart';

enum ColorsConfig {
  primary(Color(0xFFFF693B), Color(0xFFFFFFFF)),
  onPrimary(Color(0xFFFFFFFF), Color(0xFF000000)),
  secondary(Color(0xFF979797), Color(0xFFE8E8E8)),
  onSecondary(Color(0xFFF1F1F3), Color(0xFF000000)),

  /// 错误色
  error(Color(0xFF8F1515), Color(0xFFF44747)),
  onError(Color(0xFFFFFFFF), Color(0xFF000000)),

  /// 背景色
  surface(Color(0xFFF1F1F3), Color(0xFF3C3C3C)),
  onSurface(Color(0xFF6C6C6C), Color(0xFFFFFFFF)),
  scrim(Color(0xFFE6E6E6), Color(0xFF686868));

  final Color light;
  final Color dark;

  const ColorsConfig(this.light, this.dark);

  Color color(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return light;
      case Brightness.dark:
        return dark;
    }
  }
}
