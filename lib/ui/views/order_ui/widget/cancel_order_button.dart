import 'package:bloomdeliveyapp/business_logic/constants/const_colors.dart';
import 'package:bloomdeliveyapp/business_logic/utils/cancel_order.dart';
import 'package:flutter/material.dart';

class CancelOrderButton extends StatelessWidget {
  const CancelOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => cancelActiveOrder(context),
      child: Text(
        "Cancel",
        style: TextStyle(
          color: ColorsManager.red,
          fontSize: 16,
        ),
      ),
    );
  }
}
