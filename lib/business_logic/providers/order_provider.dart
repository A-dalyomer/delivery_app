import 'package:bloomdeliveyapp/business_logic/models/order/order_model.dart';
import 'package:bloomdeliveyapp/business_logic/models/order/receiver_info_model.dart';
import 'package:bloomdeliveyapp/business_logic/utils/animated_route.dart';
import 'package:bloomdeliveyapp/business_logic/utils/cancel_order.dart';
import 'package:bloomdeliveyapp/business_logic/utils/enums.dart';
import 'package:bloomdeliveyapp/ui/views/order_ui/goods_selection_screen.dart';
import 'package:bloomdeliveyapp/ui/views/order_ui/widget/select_fair_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/const_metrics.dart';

class OrderProvider extends ChangeNotifier {
  OrderSteps activeStep = OrderSteps.pickingPickupLocation;

  late OrderModel orderDetails;
  bool showOrderSummaryWidget = false;

  void changeActiveOrderStep(OrderSteps newStep) {
    activeStep = newStep;
    notifyListeners();
  }

  void setPickupLocation(LatLng pickupLocation) {
    orderDetails = OrderModel(pickupLocation: pickupLocation);
    addMoreDestinations();
  }

  void addNewDestination(LatLng newDestination) {
    if (orderDetails.destinations.isEmpty) {
      orderDetails.destinations.add(newDestination);
    } else {
      orderDetails.destinations.insert(
        orderDetails.destinations.length - 1,
        newDestination,
      );
    }
    if (orderDetails.receiverInfo == null) {
      changeActiveOrderStep(OrderSteps.receiverInfo);
    } else {
      changeActiveOrderStep(OrderSteps.confirmDetails);
    }
  }

  void removeDestination(BuildContext context, LatLng removedDestination) {
    orderDetails.destinations.remove(removedDestination);
    if (orderDetails.destinations.isEmpty) {
      cancelActiveOrder(context);
    } else {
      notifyListeners();
    }
  }

  void setReceiverInfo({
    required String name,
    required String phoneNumber,
    required String note,
  }) {
    orderDetails.receiverInfo = ReceiverInfo(
      name: name,
      phoneNumber: phoneNumber,
      note: note,
    );
    changeActiveOrderStep(
      OrderSteps.confirmDetails,
    );
  }

  void addMoreDestinations() {
    changeActiveOrderStep(
      OrderSteps.pickingDestination,
    );
  }

  void confirmOrder() {
    changeActiveOrderStep(OrderSteps.rideNow);
  }

  void rideConfirmation(BuildContext context) {
    if (orderDetails.goodsType.isEmpty) {
      setGoodsDetails(context);
    } else {
      startRideSelection(context);
    }
  }

  void setGoodsDetails(BuildContext context) async {
    String? selectedGoods = await Navigator.push(
      context,
      animatedRoute(const GoodsSelectionScreen()),
    );
    if (selectedGoods != null) {
      orderDetails.goodsType = selectedGoods;
      notifyListeners();
    }
  }

  void setRideType(RideType selectedRide) {
    orderDetails.rideType = selectedRide;
    notifyListeners();
  }

  void setOfferedPrice(double setPrice) {
    orderDetails.offeredPrice = setPrice;
    notifyListeners();
  }

  void setRecommendedFare(double setPrice) {
    orderDetails.recommendedFare = double.parse(setPrice.toStringAsFixed(2));
    notifyListeners();
  }

  void startRideSelection(BuildContext context) {
    double recommendedFare = orderDetails.recommendedFare;
    RideType rideType = orderDetails.rideType;
    double rideRecommendedFare = recommendedFare *
        (rideType == RideType.truck
            ? AppMetrics.costPerMeterTruck
            : AppMetrics.costPerMeterMotor);
    final TextEditingController fairController = TextEditingController(
      text: rideRecommendedFare.toStringAsFixed(2),
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SelectFairDialog(
          textEditingController: fairController,
          recommendedFare: "${AppMetrics.currency}$rideRecommendedFare",
          onAccepted: () {
            if (kDebugMode) {
              print('offered fare: ${fairController.text}');
            }
            if (fairController.text.isNotEmpty) {
              setOfferedPrice(double.parse(fairController.text));
              changeActiveOrderStep(OrderSteps.waitingOffer);
            }
          },
        );
      },
    );
  }

  void backInOrderSteps(BuildContext context) {
    if (activeStep.index > 1) {
      changeActiveOrderStep(OrderSteps.values[activeStep.index - 1]);
    } else {
      cancelActiveOrder(context);
    }
  }

  void cancelOrder() {
    activeStep = OrderSteps.pickingPickupLocation;
    orderDetails.resetOrder();
    notifyListeners();
  }
}
