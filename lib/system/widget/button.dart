import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DottedBorderButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const DottedBorderButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        dashPattern: const [7, 7], // 线段长度, 间隔
        strokeWidth: 1,
        radius: Radius.circular(12),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: child,
        ),
      ),
    );
  }
}
