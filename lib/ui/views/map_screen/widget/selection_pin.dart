import 'package:deliveyapp/business_logic/constants/const_assets.dart';
import 'package:flutter/material.dart';

class SelectionPin extends StatelessWidget {
  const SelectionPin({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppAssets.userLocationPinImage,
          color: color,
          height: 40,
        ),
        Container(
          height: 15,
          width: 3,
          color: color,
        ),
      ],
    );
  }
}
