import 'package:bloomdeliveyapp/business_logic/constants/const_colors.dart';
import 'package:flutter/material.dart';

class OrderDetailWidget extends StatelessWidget {
  const OrderDetailWidget({
    super.key,
    required this.title,
    required this.value,
    this.iconData,
    this.fontSize,
  });
  final String title;
  final String value;
  final IconData? iconData;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: ColorsManager.black,
            fontSize: fontSize ?? 16,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            children: [
              if (iconData != null)
                Row(
                  children: [
                    Icon(iconData, color: Colors.green),
                    SizedBox(width: 6),
                  ],
                ),
              Text(
                value,
                style: TextStyle(
                  color: ColorsManager.green,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize ?? 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
