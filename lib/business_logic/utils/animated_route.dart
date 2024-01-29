import "package:flutter/material.dart";

/// A custom route that provides a slide up and down animation on opening and closing a route
Route<String> animatedRoute(Widget newPage) {
  return PageRouteBuilder<String>(
    pageBuilder: (context, animation, secondaryAnimation) => newPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
