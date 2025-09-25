import 'package:flutter/material.dart';

Future<void> buildModalBottomSheet({
  required BuildContext context,
  required List<Widget> widgets,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 28),
          child: Column(mainAxisSize: MainAxisSize.min, children: widgets),
        ),
      );
    },
  );
}
