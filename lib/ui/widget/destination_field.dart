import 'package:deliveyapp/business_logic/constants/const_colors.dart';
import 'package:deliveyapp/ui/views/map_screen/map_screen.dart';
import 'package:deliveyapp/ui/widget/color_flag.dart';
import 'package:deliveyapp/ui/widget/delete_button.dart';
import 'package:deliveyapp/ui/widget/favourite_button.dart';
import 'package:flutter/material.dart';

import '../../business_logic/utils/enums.dart';

/// A customizable [TextField] widget themed with the app design and ui logic parameters
/// logic ui parameters includes enabling and disabling location related logics
class DestinationField extends StatelessWidget {
  const DestinationField({
    super.key,
    required this.fieldType,
    this.controller,
    this.onTap,
    this.onIconTap,
    this.onSubmitted,
    this.hasDrawerIcon = false,
    this.isEditable = false,
    this.hasDeleteButton = false,
  });
  final FieldType fieldType;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final VoidCallback? onIconTap;
  final Function(String)? onSubmitted;
  final bool hasDrawerIcon;
  final bool isEditable;
  final bool hasDeleteButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (hasDrawerIcon)
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 5),
            child: Container(
              decoration: BoxDecoration(
                color: ColorsManager.lightTeal,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () => scaffoldKey2.currentState?.openDrawer(),
                  borderRadius: BorderRadius.circular(12),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.menu, color: ColorsManager.black),
                  ),
                ),
              ),
            ),
          ),
        Flexible(
          child: TextField(
            controller: controller,
            onTap: onTap,
            canRequestFocus: isEditable,
            contextMenuBuilder: (context, editableTextState) =>
                const SizedBox.shrink(),
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              hintText: 'Enter Destination Address',
              hintStyle: const TextStyle(color: ColorsManager.greyText),
              filled: true,
              fillColor: controller?.text.isEmpty == null
                  ? ColorsManager.grey
                  : ColorsManager.lightTeal,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: ColorsManager.green),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              prefixIconConstraints: const BoxConstraints(
                maxHeight: 25,
                maxWidth: 50,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.5),
                child: ColorFlag(
                  color:
                      fieldType == FieldType.pickUp ? Colors.green : Colors.red,
                ),
              ),
              suffixIcon: hasDeleteButton
                  ? DeleteButton(onTap: onIconTap)
                  : controller?.text != null
                      ? FavouriteButton(
                          onTap: (value) {},
                        )
                      : null,
            ),
          ),
        ),
      ],
    );
  }
}
