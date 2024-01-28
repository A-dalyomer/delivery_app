import 'package:flutter/material.dart';

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
      icon: Icon(
        Icons.delete_forever,
        color: Colors.red,
      ),
    );
  }
}
