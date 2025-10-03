import 'package:aime/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// 搜索框
class SearchTextField extends StatelessWidget {
  final TextEditingController controller;

  const SearchTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: l10n.search,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          prefixIcon: const Icon(LucideIcons.search300),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
            icon: const Icon(LucideIcons.x300),
            onPressed: () {
              controller.text = "";
            },
          )
              : null,
        ),
        onChanged: (value) => controller.text = value,
      ),
    );
  }
}

