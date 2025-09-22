import 'package:flutter/material.dart';

class PageDivider extends StatelessWidget {
  const PageDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: Colors.black.withValues(alpha: 0.15),
      thickness: 1,
      width: 10,
      indent: 35,
      endIndent: 35,
    );
  }
}

class ListTileDivider extends StatelessWidget {
  const ListTileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.black.withValues(alpha: 0.15),
      thickness: 1,
      height: 1,
    );
  }
}
