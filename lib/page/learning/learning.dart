import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../config/style_config.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({super.key});

  @override
  _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        LucideIcons.libraryBig200,
        size: 80,
        color: AppColors.primary,
      ),
    );
  }
}
