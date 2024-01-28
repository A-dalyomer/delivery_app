/// used to determine the order steps and the current active one
enum OrderSteps {
  pickingPickupLocation,
  pickingDestination,
  receiverInfo,
  confirmDetails,
  rideNow,
  waitingOffer,
}

enum MapSelectionMode { none, pickup, destination }

enum RideType { motor, truck }

enum RouteApiMode { osrm, google }
