
import 'dart:io';

import 'package:aime/page/settings/settings.dart';
import 'package:aime/page/settings/suggest.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/app_info.dart';
import '../../helper/screen_helper.dart';
import '../../l10n/app_localizations.dart';
import '../../system/widget/list.dart';

class About extends StatelessWidget {
  About({super.key});

  final InAppReview _inAppReview = InAppReview.instance;
  static const String _appName = AppInfo.appName;
  static const String _version = AppInfo.appVersion;
  static const String _buildVersion = AppInfo.appBuildVersion;

  Future<void> _requestReview() async {
    try {
      // 先检查是否支持原生内置评分弹窗
      if (await _inAppReview.isAvailable()) {
        await _inAppReview.requestReview();
      } else {
        // 如果不支持，跳转到商店
        await _inAppReview.openStoreListing();
      }
    } catch (e) {
      debugPrint("评分失败: $e");
    }
  }

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
            'assets/images/logo-splash-2.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: Text(
              "$_appName v$_version #Build $_buildVersion",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          buildListTile(context, LucideIcons.star400, l10n.rating, () {
            _requestReview();
          }),
          buildListTile(context, LucideIcons.link, l10n.suggestAndIdea, () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => SuggestPage()));
          }),
        ],
      ),
    );
  }
}

BottomSheet _ContactAuthorBottomSheet(context){
  return BottomSheet(
    onClosing: (){
      print("closed");
    },

    builder: (context){
      return Container(
        height: 300,
        color: Colors.yellow,
        alignment: Alignment.centerLeft,
        child: Text("BottomSheet In Scaffold"),
      );
    },
  );
}

class ContactAuthorDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("联系作者"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("选择一种方式联系作者："),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text("邮箱"),
                onTap: () {
                  _launchUrl("mailto:author@example.com");
                  Navigator.pop(ctx);
                },
              ),
              if (Platform.isAndroid) // 安卓可显示电话
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text("电话"),
                  onTap: () {
                    _launchUrl("tel:+8613800000000");
                    Navigator.pop(ctx);
                  },
                ),
              ListTile(
                leading: const Icon(Icons.code),
                title: const Text("GitHub"),
                onTap: () {
                  _launchUrl("https://github.com/username");
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat),
                title: const Text("QQ"),
                onTap: () {
                  _launchUrl("tencent://message/?uin=123456&Site=&Menu=yes");
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("取消"),
            ),
          ],
        );
      },
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
