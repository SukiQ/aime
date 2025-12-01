import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/system/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
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
                  child: SizedBox(
                    width: 130,
                    height: 90,
                    child: Center(child: Iconify(
                      model.icon,
                      size: 40,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 5),
                //   child: Text(
                //     model.name(context),
                //     style: TextStyle(
                //       fontSize: 12,
                //       fontWeight: FontWeight.w300,
                //       color: Theme.of(context).colorScheme.secondary,
                //     ),
                //   ),
                // ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
