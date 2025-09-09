import 'package:aime/page/settings/settings.dart';
import 'package:flutter/material.dart';

import '../../helper/screen_helper.dart';
import '../../l10n/app_localizations.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);

    return Scaffold(
      appBar: isWide ? null : AppBar(title: Text(l10n.about)),
      body: Column(
        children: [
          if (isWide) buildWideAppBar(l10n.about),
          Image.asset(
            'resource/images/config/logo-splash.png',
            height: 100,
            fit: BoxFit.cover, // 填充方式
          )
        ],
      ),
    );
  }

}