import 'package:bloomdeliveyapp/business_logic/constants/const_colors.dart';
import 'package:bloomdeliveyapp/business_logic/providers/map_provider.dart';
import 'package:bloomdeliveyapp/business_logic/utils/enums.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/widget/selection_pin.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key, required this.mapProvider});
  final MapProvider mapProvider;
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(25.0000, 55.0000),
  );

  Widget selectionIcon(MapSelectionMode selectionMode) {
    switch (selectionMode) {
      case MapSelectionMode.none:
        return const SizedBox.shrink();
      case MapSelectionMode.pickup:
        return const SelectionPin(color: ColorsManager.blue);
      case MapSelectionMode.destination:
        return const SelectionPin(color: ColorsManager.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) => mapProvider.onMapCreated(
            controller: controller,
            initialCameraLocation: _initialPosition,
          ),
          initialCameraPosition: _initialPosition,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onCameraIdle: () => mapProvider.updateFieldController(isIdle: true),
          onCameraMove: (position) => mapProvider.updateFieldController(
            position: position,
            isIdle: false,
          ),
          myLocationEnabled: mapProvider.showUserLocation,
          markers: mapProvider.markers,
          polylines: mapProvider.polyLines,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              selectionIcon(mapProvider.mapSelectionMode),

              /// to raise the pin according to the small line under it
              const SizedBox(height: 60)
            ],
          ),
        )
      ],
    );
  }
}
