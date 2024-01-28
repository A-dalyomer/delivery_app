import 'package:flutter/material.dart';

import '../../business_logic/constants/const_colors.dart';

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
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 28,
          ),
          child: Text(
            "-10",
            style: TextStyle(
              color: ColorsManager.white,
            ),
          ),
        ),
      ),
    );
  }
}
