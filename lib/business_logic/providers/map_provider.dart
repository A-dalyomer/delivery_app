import 'package:bloomdeliveyapp/business_logic/constants/const_colors.dart';
import 'package:bloomdeliveyapp/business_logic/utils/enums.dart';
import 'package:bloomdeliveyapp/services/get_user_location.dart';
import 'package:bloomdeliveyapp/services/map/map_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/generate_marker.dart';

class MapProvider extends ChangeNotifier {
  MapProvider() {
    getUserLocation();
  }
  late GoogleMapController mapController;
  final TextEditingController fieldController = TextEditingController();

  /// UI settings
  MapSelectionMode mapSelectionMode = MapSelectionMode.pickup;
  bool showingMap = true;
  bool showUserLocation = false;
  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};
  LatLng selectedLocation = const LatLng(0, 0);
  double approximateDistance = 0;

  void onMapCreated({
    required GoogleMapController controller,
    required CameraPosition initialCameraLocation,
  }) {
    mapController = controller;
    selectedLocation = initialCameraLocation.target;
    updateFieldController(isIdle: false, position: initialCameraLocation);
    notifyListeners();
  }

  void changeMapSelectionMode(MapSelectionMode newSelectionMode) {
    mapSelectionMode = newSelectionMode;
    notifyListeners();
  }

  void changeMapShowState(bool newState) {
    showingMap = newState;
    notifyListeners();
  }

  void updateFieldController({
    required bool isIdle,
    CameraPosition? position,
  }) async {
    if (isIdle) {
      notifyListeners();
      return;
    }
    if (position != null) {
      selectedLocation = position.target;
      fieldController.text =
          '${selectedLocation.latitude}, ${selectedLocation.longitude}';
      if (kDebugMode) {
        print('camera idle on location: ${fieldController.text}');
      }
    }
  }

  Future<void> getUserLocation() async {
    Position position = await LocationProvider.determineUserLocation();
    setCurrentSelectedLocation(LatLng(position.latitude, position.longitude));
    animateCameraToPosition(selectedLocation);
    fieldController.text = '${position.latitude}, ${position.longitude}';
    showUserLocation = true;
    notifyListeners();
  }

  Future<void> addMarker({
    required LatLng position,
    required String markerId,
    required MapSelectionMode mode,
  }) async {
    markers.add(
      await generateMarker(
        markerId: markerId,
        position: position,
        title: mode.name,
        color: mode == MapSelectionMode.pickup
            ? ColorsManager.green
            : ColorsManager.red,
      ),
    );
  }

  void addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("polyline");
    Polyline polyline = Polyline(
      polylineId: id,
      color: ColorsManager.red,
      points: polylineCoordinates,
      width: 4,
    );
    polyLines.add(polyline);
  }

  void setCurrentSelectedLocation(LatLng newPickedLocation) {
    selectedLocation = newPickedLocation;
    notifyListeners();
  }

  Future<void> animateCameraToPosition(LatLng newCameraPosition) async {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: newCameraPosition,
          zoom: 14.0,
        ),
      ),
    );
  }

  void createRouteOnMap({
    required LatLng pickLocation,
    required List<LatLng> destinations,
  }) async {
    if (kDebugMode) {
      print('getting routes of ${destinations.length} destinations');
      print(destinations);
    }
    List<LatLng> polylineCoordinates = [];

    markers.clear();

    await addMarker(
      position: pickLocation,
      markerId: 'pick_up',
      mode: MapSelectionMode.pickup,
    );

    for (var element in destinations) {
      await addMarker(
        markerId: '${element.latitude},${element.longitude}',
        position: element,
        mode: MapSelectionMode.destination,
      );
    }
    notifyListeners();

    if (kDebugMode) {
      print("total markers: ${markers.length}");
      print("total destinations: ${destinations.length}");
    }

    MapServices mapServices = MapServices();
    polylineCoordinates = await mapServices.getRoute(
      apiMode: RouteApiMode.osrm,
      points: [pickLocation, ...destinations],
    );
    addPolyLine(polylineCoordinates);
    approximateDistance = await mapServices.calculateTotalDistance(
      [pickLocation, ...destinations],
    );
    if (kDebugMode) {
      print('calculated distance: $approximateDistance');
    }
    notifyListeners();
  }

  void reset() {
    mapSelectionMode = MapSelectionMode.pickup;
    showingMap = true;
    markers.clear();
    polyLines.clear();
    getUserLocation();
  }
}
