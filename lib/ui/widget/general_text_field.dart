import 'package:deliveyapp/business_logic/constants/const_colors.dart';
import 'package:flutter/material.dart';

/// A customizable [TextField] widget with the app design theme
class GeneralTextField extends StatelessWidget {
  const GeneralTextField({
    super.key,
    this.controller,
    required this.inputType,
    required this.inputAction,
    this.validator,
    this.hintText,
    this.maxLines = 1,
  });
  final TextEditingController? controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final String? hintText;
  final int maxLines;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => validator != null ? validator!(value) : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorsManager.lightTeal,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorsManager.grey, width: 2),
        ),
      ),
      keyboardType: inputType,
      textInputAction: inputAction,
      maxLines: maxLines,
    );
  }
}
