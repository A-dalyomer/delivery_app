import 'package:flutter/material.dart';

/// Simple toggle button for favourite icon
class FavouriteButton extends StatefulWidget {
  const FavouriteButton({super.key, this.onTap});
  final Function(bool)? onTap;

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() => isFavourite = !isFavourite);
        widget.onTap?.call(isFavourite);
      },
      icon: Icon(
        isFavourite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
    );
  }
}
