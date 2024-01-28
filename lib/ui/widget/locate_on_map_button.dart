import 'package:bloomdeliveyapp/business_logic/constants/const_colors.dart';
import 'package:flutter/material.dart';

import 'color_flag.dart';

class LocateOnMapButton extends StatelessWidget {
  const LocateOnMapButton({super.key, required this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColorFlag(color: ColorsManager.red, size: 30),
          SizedBox(width: 10),
          Text(
            'Locate on map',
            style: TextStyle(color: ColorsManager.green),
          ),
        ],
      ),
    );
  }
}
