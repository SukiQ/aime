import 'dart:io';

import 'package:flutter/material.dart';

class ScreenHelper {
  /// 默认宽屏的断点，单位 px
  static const double wideScreenBreakpoint = 600;

  /// 是否为宽屏（>= 600）
  static bool isWide(BuildContext context, {double? breakpoint}) {
    final width = MediaQuery.of(context).size.width;
    return width >= (breakpoint ?? wideScreenBreakpoint);
  }

  /// 是否为窄屏（< 600）
  static bool isNarrow(BuildContext context, {double? breakpoint}) {
    return !isWide(context, breakpoint: breakpoint);
  }

  static bool isPhone() {
    return Platform.isAndroid || Platform.isIOS;
  }
}
