/// used to determine the order steps and the current active one
enum OrderSteps {
  pickingPickupLocation,
  pickingDestination,
  receiverInfo,
  confirmDetails,
  rideNow,
  waitingOffer,
}

/// map selection modes
/// the [none] value indicates that the map has no active selection mode
/// the [pickup] value indicates that the map is set to select the pickup location
/// the [destination] value indicates that the map is set to select a destination location
enum MapSelectionMode { none, pickup, destination }

/// ride type modes
enum RideType { motor, truck }

/// map routes loading api selection
/// the [osrm] is free to use api
/// the [google] is paid per request api
enum RouteApiMode { osrm, google }
