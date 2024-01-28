import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/enums.dart';
import 'receiver_info_model.dart';

class OrderModel {
  OrderModel({required this.pickupLocation});

  LatLng? pickupLocation;
  List<LatLng> destinations = [];
  ReceiverInfo? receiverInfo;
  String goodsType = '';
  int goodsCount = 1;
  double offeredPrice = 50;
  double recommendedFare = 0;
  RideType rideType = RideType.motor;

  void resetOrder() {
    pickupLocation = null;
    destinations.clear();
    receiverInfo = null;
    goodsType = '';
    goodsCount = 1;
    offeredPrice = 50;
  }
}
