import 'package:bloomdeliveyapp/business_logic/constants/const_colors.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/map_screen.dart';
import 'package:bloomdeliveyapp/ui/widget/color_flag.dart';
import 'package:bloomdeliveyapp/ui/widget/delete_button.dart';
import 'package:bloomdeliveyapp/ui/widget/favourite_button.dart';
import 'package:flutter/material.dart';

enum FieldType { pickUp, destination }

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
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
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
                SizedBox.shrink(),
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              hintText: 'Enter Destination Address',
              hintStyle: TextStyle(color: ColorsManager.greyText),
              filled: true,
              fillColor: controller?.text.isEmpty == null
                  ? ColorsManager.grey
                  : ColorsManager.lightTeal,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColorsManager.green),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              prefixIconConstraints: BoxConstraints(
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
