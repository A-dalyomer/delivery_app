import 'package:deliveyapp/business_logic/constants/const_colors.dart';
import 'package:deliveyapp/business_logic/utils/enums.dart';
import 'package:deliveyapp/services/get_user_location.dart';
import 'package:deliveyapp/services/map/map_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../services/map/generate_marker.dart';

class MapProvider extends ChangeNotifier {
  MapProvider() {
    getUserLocation();
  }

  /// non changed controllers
  late GoogleMapController mapController;
  final TextEditingController fieldController = TextEditingController();

  /// map UI settings
  MapSelectionMode mapSelectionMode = MapSelectionMode.pickup;
  bool showingMap = true;
  bool showUserLocation = false;

  /// value holders
  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};
  LatLng selectedLocation = const LatLng(0, 0);

  /// total trip distance
  /// saved here to preserve not linking the order provider with the map provider which is not recommended
  double approximateDistance = 0;

  /// used to initialize the map controller with a value from the map widget
  /// assigns the initial value for the [selectedLocation]
  /// assigns the first value on the [fieldController]
  void onMapCreated({
    required GoogleMapController controller,
    required CameraPosition initialCameraLocation,
  }) {
    mapController = controller;
    selectedLocation = initialCameraLocation.target;
    updateFieldController(isIdle: false, position: initialCameraLocation);
    notifyListeners();
  }

  /// controls the [mapSelectionMode] value which in turn changes the selection mode of the map screen
  void changeMapSelectionMode(MapSelectionMode newSelectionMode) {
    mapSelectionMode = newSelectionMode;
    notifyListeners();
  }

  /// toggles the current map existence in the widget tree by changing the [showingMap] value
  void changeMapShowState(bool newState) {
    showingMap = newState;
    notifyListeners();
  }

  /// updates the [selectedLocation] and [fieldController] text on map camera movement
  /// only notifies widget listeners when the map camera stops moving
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

  /// gets user location based on device GPS
  /// initializes the position value holders with the supplied position
  Future<void> getUserLocation() async {
    Position position = await LocationProvider.determineUserLocation();
    setCurrentSelectedLocation(LatLng(position.latitude, position.longitude));
    animateCameraToPosition(selectedLocation);
    fieldController.text = '${position.latitude}, ${position.longitude}';
    showUserLocation = true;
    notifyListeners();
  }

  /// add a marker to the [markers]
  /// which then gets loaded on the map on the next rebuild
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

  /// adds the provided polyline to [polyLines]
  /// which is shown on the map on next rebuild
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

  /// set the value for selected location by user on the map
  void setCurrentSelectedLocation(LatLng newPickedLocation) {
    selectedLocation = newPickedLocation;
    notifyListeners();
  }

  /// animate the map camera to the new position using the existing controller
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

  /// clears the existing markers on map
  /// prepares new markers based on the current pickup and destination values
  /// notify widget listeners to show the markers immediately
  /// requests the route data
  /// add the loaded route to the [polyLines] to be shown on the map
  /// notify widget listener to show the new polyline on the map
  /// calculate trip total distance in meters
  void createRouteOnMap({
    required LatLng pickLocation,
    required List<LatLng> destinations,
  }) async {
    if (kDebugMode) {
      print('getting routes of ${destinations.length} destinations');
      print(destinations);
    }

    /// used variables
    List<LatLng> polylineCoordinates = [];

    /// clear existing markers
    markers.clear();

    /// load the new markers
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

    /// prepare the polyline data with the selected provider type
    MapServices mapServices = MapServices();
    polylineCoordinates = await mapServices.getRoute(
      apiMode: RouteApiMode.osrm,
      points: [pickLocation, ...destinations],
    );
    addPolyLine(polylineCoordinates);

    /// calculate the total distance of the trip
    approximateDistance = await mapServices.calculateTotalDistance(
      [pickLocation, ...destinations],
    );
    if (kDebugMode) {
      print('calculated distance: $approximateDistance');
    }
    notifyListeners();
  }

  /// reset the provider state to the initial values
  void reset() {
    mapSelectionMode = MapSelectionMode.pickup;
    showingMap = true;
    markers.clear();
    polyLines.clear();
    notifyListeners();
    getUserLocation();
  }
}
