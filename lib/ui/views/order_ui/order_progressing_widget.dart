import 'package:bloomdeliveyapp/business_logic/providers/order_provider.dart';
import 'package:bloomdeliveyapp/business_logic/utils/enums.dart';
import 'package:bloomdeliveyapp/ui/views/order_ui/widget/confirm_details_order_ui.dart';
import 'package:bloomdeliveyapp/ui/views/order_ui/widget/destination_location_order_ui.dart';
import 'package:bloomdeliveyapp/ui/views/order_ui/widget/pickup_location_order_ui.dart';
import 'package:bloomdeliveyapp/ui/views/order_ui/widget/receiver_info_order_ui.dart';
import 'package:bloomdeliveyapp/ui/views/order_ui/widget/ride_now_order_ui.dart';
import 'package:bloomdeliveyapp/ui/views/order_ui/widget/waiting_offer_order_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderProgressingWidget extends StatelessWidget {
  const OrderProgressingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    switch (orderProvider.activeStep) {
      case OrderSteps.pickingPickupLocation:
        return const PickupLocationOrderUI();
      case OrderSteps.pickingDestination:
        return const DestinationLocationOrderUI();
      case OrderSteps.receiverInfo:
        return const ReceiverInfoOrderUI();
      case OrderSteps.confirmDetails:
        return const ConfirmDetailsOrderUI();
      case OrderSteps.rideNow:
        return const RideNowOrderUI();
      case OrderSteps.waitingOffer:
        return const WaitingOfferOrderUI();
    }
  }
}
