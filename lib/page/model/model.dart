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
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        children: ModelEnum.values.map((model) {
          return OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              side: BorderSide.none,
              backgroundColor: Theme.of(context).colorScheme.surface,
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
                Icon(
                  model.icon,
                  size: 50,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  model.name(context),
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
