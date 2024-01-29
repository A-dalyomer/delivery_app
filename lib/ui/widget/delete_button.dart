import 'package:flutter/material.dart';

/// An icon button with delete icon inside
/// calls the provided [onTap] that provides the deletion logic
class DeleteButton extends StatefulWidget {
  const DeleteButton({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onTap,
      icon: const Icon(
        Icons.delete_forever,
        color: Colors.red,
      ),
    );
  }
}
