import 'package:flutter/cupertino.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../config/style_config.dart';

class ModelPage extends StatelessWidget {
  const ModelPage({super.key});


  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(LucideIcons.codesandbox200,size: 80,color: AppColors.primary,));
  }
}
