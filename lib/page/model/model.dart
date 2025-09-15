import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ModelPage extends StatelessWidget{
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("点击了添加")),
              );
            },
          ),
          IconButton(
            icon: const Icon(LucideIcons.minus400),
            tooltip: l10n.modelRemoveLabel,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("点击了删除")),
              );
            },
          ),
        ],
      ),
      body: GridView.custom(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        childrenDelegate: SliverChildBuilderDelegate(
              (context, index) {
            return Card(
              child: Center(child: Text('Item $index')),
            );
          },
          childCount: 20, // 数据的数量
        ),
      ),
    );
  }

}
