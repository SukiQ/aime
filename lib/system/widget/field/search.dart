import 'package:aime/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// 搜索框
class SearchTextField extends StatefulWidget {
  final TextEditingController controller;

  const SearchTextField({super.key, required this.controller});

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          filled:  true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.transparent,
            )),
          fillColor: Theme.of(context).colorScheme.scrim,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: l10n.search,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          prefixIcon: const Icon(LucideIcons.search300),
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(LucideIcons.x300),
                  onPressed: () {
                    setState(() => widget.controller.text = "");
                  },
                )
              : null,
        ),
        onChanged: (value) => setState(() => widget.controller.text = value),
      ),
    );
  }
}
