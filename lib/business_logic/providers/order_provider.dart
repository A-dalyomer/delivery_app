import 'package:deliveyapp/business_logic/models/order/order_model.dart';
import 'package:deliveyapp/business_logic/models/order/receiver_info_model.dart';
import 'package:deliveyapp/business_logic/utils/animated_route.dart';
import 'package:deliveyapp/services/order/cancel_order.dart';
import 'package:deliveyapp/business_logic/utils/enums.dart';
import 'package:deliveyapp/ui/views/order_ui/goods_selection_screen.dart';
import 'package:deliveyapp/ui/views/order_ui/widget/select_fair_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/const_metrics.dart';

class OrderProvider extends ChangeNotifier {
  /// holds the current order step state
  OrderSteps activeStep = OrderSteps.pickingPickupLocation;

  /// active order data state
  late OrderModel orderDetails;

  /// emits new order step state
  /// which in turn changes the active order step widget
  void changeActiveOrderStep(OrderSteps newStep) {
    activeStep = newStep;
    notifyListeners();
  }

  /// set the pick up location value in the saved order state
  void setPickupLocation(LatLng pickupLocation) {
    orderDetails = OrderModel(pickupLocation: pickupLocation);
    addMoreDestinations();
  }

  /// adds new destination to the saved order state
  /// then changes the order step to the next one
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

  /// removes a specified destination from the saved destinations in the saved state
  /// then notifies the listening widget if any left
  /// if none left it cancels the active order removing all the saved state data
  void removeDestination(BuildContext context, LatLng removedDestination) {
    orderDetails.destinations.remove(removedDestination);
    if (orderDetails.destinations.isEmpty) {
      cancelActiveOrder(context);
    } else {
      notifyListeners();
    }
  }

  /// set the value for receiver info in the saved state
  /// then changes the active order step to the next one
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

  /// changes the order step back to the destination picker
  void addMoreDestinations() {
    changeActiveOrderStep(
      OrderSteps.pickingDestination,
    );
  }

  /// changes the order step to the next one as confirming the order
  void confirmOrder() {
    changeActiveOrderStep(OrderSteps.rideNow);
  }

  /// checks if goods type is selected
  /// if selected, it goes to next step which is [startRideSelection]
  /// is not selected, it starts the goods selection process
  void rideConfirmation(BuildContext context) {
    if (orderDetails.goodsType.isEmpty) {
      setGoodsDetails(context);
    } else {
      startRideSelection(context);
    }
  }

  /// sets the goods type in the saved order state
  /// which involves navigating to the [GoodsSelectionScreen]
  /// then receiving the resulted value from the screen
  /// then saves the result in the saved order state
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

  /// set the ride type in the saved order state and notified the listening widget
  void setRideType(RideType selectedRide) {
    orderDetails.rideType = selectedRide;
    notifyListeners();
  }

  /// set the offered price in the saved order state
  void setOfferedPrice(double setPrice) {
    orderDetails.offeredPrice = setPrice;
    notifyListeners();
  }

  /// set the recommended fare value in the saved order state
  void setRecommendedFare(double setPrice) {
    orderDetails.recommendedFare = double.parse(setPrice.toStringAsFixed(2));
    notifyListeners();
  }

  /// shows the order summary dialog with the associated logic
  void startRideSelection(BuildContext context) {
    double recommendedFare = orderDetails.recommendedFare;
    RideType rideType = orderDetails.rideType;
    double rideRecommendedFare = recommendedFare *
        (rideType == RideType.truck
            ? AppMetrics.costPerMeterTruck
            : AppMetrics.costPerMeterMotor);
    String formattedRecommendedFare = rideRecommendedFare.toStringAsFixed(2);
    final TextEditingController fairController = TextEditingController(
      text: formattedRecommendedFare,
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SelectFairDialog(
          textEditingController: fairController,
          recommendedFare: "${AppMetrics.currency}$formattedRecommendedFare",
          rideType: rideType,
          onAccepted: () {
            if (kDebugMode) {
              print('offered fare: ${fairController.text}');
            }
            if (fairController.text.isNotEmpty) {
              /// set the offered price by user from the text field
              setOfferedPrice(double.parse(fairController.text));

              /// changes the active order step to the next one
              changeActiveOrderStep(OrderSteps.waitingOffer);
            }
          },
        );
      },
    );
  }

  /// handles the logic of back button in the order progress
  /// if not on the second step, it changes to one step back
  /// if on the second step, it cancels the active order
  void backInOrderSteps(BuildContext context) {
    if (activeStep.index > 1) {
      changeActiveOrderStep(OrderSteps.values[activeStep.index - 1]);
    } else {
      cancelActiveOrder(context);
    }
  }

  /// cancel the active order and reset the state values
  void cancelOrder() {
    activeStep = OrderSteps.pickingPickupLocation;
    orderDetails.resetOrder();
    notifyListeners();
  }
}
