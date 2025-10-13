import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'm_enums.dart';

class ModelPage extends StatelessWidget {
  const ModelPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.plus400),
            tooltip: l10n.modelAddLabel,
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("点击了添加")));
            },
          ),
          IconButton(
            icon: const Icon(LucideIcons.minus400),
            tooltip: l10n.modelRemoveLabel,
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("点击了删除")));
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(isWide ? 10 : 0),
        child: GridView.extent(
          childAspectRatio: 1,
          physics: const BouncingScrollPhysics(),
          maxCrossAxisExtent: 150,
          children: ModelEnum.values.map((model) {
            return Padding(padding: EdgeInsets.all(5),child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => model.widget),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(flex: 6, child: Icon(
                    model.icon,
                    size: 50,
                    color: Theme.of(context).colorScheme.secondary,
                  )),
                  Divider(
                    color: Theme.of(context).colorScheme.scrim,
                    thickness: 1,
                    height: 0.2,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Expanded(flex: 3, child: Padding(padding: EdgeInsets.only(top: 10),child: Text(
                    model.name(context),
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )))
                ],
              ),
            ));
          }).toList(),
        ),
      ),
    );
  }
}