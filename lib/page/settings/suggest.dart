import 'package:aime/setting/app_info.dart';
import 'package:aime/page/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/system/widget/list.dart';
import 'package:aime/system/widget/page.dart';

class SuggestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);

    return Scaffold(
      appBar: isWide ? null : AppBar(title: Text(l10n.suggestAndIdea)),
      body: ViewPage(
        child: Column(
          children: [
            if (isWide) buildWideAppBar(l10n.suggestAndIdea),
            buildLevel1ListTile(
              context,
              SimpleIcons.instagram,
              l10n.instagram,
              () {
                _launchUrl(AppInfo.appAuthorInstagram);
              },
            ),
            buildLevel1ListTile(context, SimpleIcons.x, l10n.x, () {
              _launchUrl(AppInfo.appAuthorX);
            }),
            buildLevel1ListTile(context, SimpleIcons.wechat, l10n.weChat, () {
              _launchUrl(AppInfo.appAuthorWechat);
            }),
            buildLevel1ListTile(
              context,
              SimpleIcons.xiaohongshu,
              l10n.xiaohongshu,
              () {
                _launchUrl(AppInfo.appAuthorXiaohongshu);
              },
            ),
            buildLevel1ListTile(context, SimpleIcons.sinaweibo, l10n.weibo, () {
              _launchUrl(AppInfo.appAuthorWeibo);
            }),
          ],
        ),
      ),
    );
  }

  static Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("无法打开链接: $url");
    }
  }
}
