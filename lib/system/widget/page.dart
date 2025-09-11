import 'package:flutter/material.dart';

import 'package:aime/helper/screen.dart';

class ViewPage extends StatelessWidget {
  ViewPage({super.key, required this.child});

  Widget child;

  @override
  Widget build(BuildContext context) {
    final isWide = ScreenHelper.isWide(context);

    return Center(child: child);
  }
}
