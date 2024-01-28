import 'package:flutter/material.dart';

class ColorFlag extends StatelessWidget {
  const ColorFlag({super.key, required this.color, this.size});
  final Color color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withOpacity(.5),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ));
  }
}
