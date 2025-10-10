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
          childAspectRatio: 0.93,
          physics: const BouncingScrollPhysics(),
          maxCrossAxisExtent: 150,
          children: ModelEnum.values.map((model) {
            return Padding(padding: EdgeInsets.all(5),child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: model.color,
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
                    height: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Expanded(flex: 3, child: Padding(padding: EdgeInsets.only(top: 10),child: Text(
                    model.name(context),
                    style: TextStyle(
                      fontSize: 13,
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

class TriangleCard extends StatelessWidget {
  const TriangleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          // 🔹 卡片主体内容
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "标题",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text("这里是卡片的内容，示例文本。"),
              ],
            ),
          ),

          // 🔺 右上角的三角形
          Positioned(
            top: 0,
            right: 0,
            child: CustomPaint(
              size: const Size(40, 40), // 控制三角形大小
              painter: _TrianglePainter(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}

// 自定义三角形画笔
class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(size.width, 0) // 右上角
      ..lineTo(size.width, size.height) // 右下角
      ..lineTo(0, 0) // 左上角
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
