import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
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
          padding: const EdgeInsets.all(10),
          childAspectRatio: 1,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          physics: const BouncingScrollPhysics(),
          maxCrossAxisExtent: 90,
          children: ModelEnum.values.map((model) {
            return NeumorphicButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => model.widget),
                );
              },
              style: NeumorphicStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                depth: 6,
                // 阴影深度：正数 = 外凸，负数 = 内凹
                intensity: 0.7,
                // 阴影强度
                lightSource: LightSource.topLeft,
                // 光源方向
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(8),
                ),
              ),
              child:
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(flex: 3, child: Icon(
                      model.icon,
                      size: 35,
                      color: Theme.of(context).colorScheme.primary,
                    )),
                    Expanded(flex: 3, child: Padding(padding: EdgeInsets.only(top: 10),child: Text(
                      model.name(context),
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )))
                  ],
                ),
            );
            // OutlinedButton(
            //   style: OutlinedButton.styleFrom(
            //     backgroundColor: Theme.of(context).colorScheme.onSecondary,
            //   ),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => model.widget),
            //     );
            //   },
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Expanded(flex: 6, child: Icon(
            //         model.icon,
            //         size: 50,
            //         color: Theme.of(context).colorScheme.secondary,
            //       )),
            //       Divider(
            //         color: Theme.of(context).colorScheme.scrim,
            //         thickness: 1,
            //         height: 0.2,
            //         indent: 20,
            //         endIndent: 20,
            //       ),
            //       Expanded(flex: 3, child: Padding(padding: EdgeInsets.only(top: 10),child: Text(
            //         model.name(context),
            //         style: TextStyle(
            //           fontSize: 14,
            //           color: Theme.of(context).colorScheme.secondary,
            //         ),
            //       )))
            //     ],
            //   ),
            // ));
          }).toList(),
        ),
      ),
    );
  }
}
