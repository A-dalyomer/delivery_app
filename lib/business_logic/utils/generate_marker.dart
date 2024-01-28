import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../ui/views/map_screen/widget/marker_widget.dart';

Future<Marker> generateMarker({
  required String markerId,
  required LatLng position,
  required String title,
  Color? color,
}) async {
  return Marker(
    markerId: MarkerId(markerId),
    position: position,
    icon: await MarkerWidget(
      title: title,
      color: color,
    ).toBitmapDescriptor(
      logicalSize: const Size(200, 200),
      imageSize: const Size(400, 400),
    ),
  );
}
