import 'package:flutter/material.dart';

import '../../business_logic/constants/const_colors.dart';

/// Button widget used for secondary logic in the screen
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.title,
    this.onTap,
    this.color,
  });
  final String title;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? ColorsManager.green,
        borderRadius: BorderRadius.circular(26),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 28,
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: ColorsManager.white,
            ),
          ),
        ),
      ),
    );
  }
}
