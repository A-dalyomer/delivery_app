import 'package:flutter/material.dart';

import '../../../../business_logic/constants/const_colors.dart';

class MarkerWidget extends StatelessWidget {
  const MarkerWidget({required this.title, this.color, super.key});
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.lightTeal,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: ColorsManager.black,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Icon(
                Icons.star,
                color: color,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(color: ColorsManager.black),
            ),
          ),
        ],
      ),
    );
  }
}
