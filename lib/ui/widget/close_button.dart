import 'package:flutter/material.dart';

import '../../business_logic/constants/const_colors.dart';

class CloseWidgetButton extends StatelessWidget {
  const CloseWidgetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: ColorsManager.lightTeal,
        borderRadius: BorderRadius.circular(200),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(200),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(200),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                border: Border.all(color: Colors.red),
              ),
              child: const Icon(
                Icons.close,
                color: ColorsManager.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
