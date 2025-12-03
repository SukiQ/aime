import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/system/widget/button.dart';
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
          padding: const EdgeInsets.all(5),
          childAspectRatio: 1.2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          physics: const BouncingScrollPhysics(),
          maxCrossAxisExtent: 150,
          children: ModelEnum.values.map((model) {
            return Column(
              children: [
                DottedBorderButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => model.widget),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                      left: 10,
                      right: 10,
                    ),
                    // 内边距
                    height: 100,
                    color: Theme.of(context).colorScheme.surface,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center, // 左对齐
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                model.name(context),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: Theme.of(context).colorScheme.scrim,
                          thickness: 0.8,
                          indent: 3,
                          endIndent: 3,
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // 左对齐
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    model.icon,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    size: 23, // Icon大小
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
