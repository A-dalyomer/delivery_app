import 'package:deliveyapp/business_logic/providers/order_provider.dart';
import 'package:deliveyapp/business_logic/utils/enums.dart';
import 'package:deliveyapp/ui/views/order_ui/widget/confirm_details_order_ui.dart';
import 'package:deliveyapp/ui/views/order_ui/widget/destination_location_order_ui.dart';
import 'package:deliveyapp/ui/views/order_ui/widget/pickup_location_order_ui.dart';
import 'package:deliveyapp/ui/views/order_ui/widget/receiver_info_order_ui.dart';
import 'package:deliveyapp/ui/views/order_ui/widget/ride_now_order_ui.dart';
import 'package:deliveyapp/ui/views/order_ui/widget/waiting_offer_order_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/constants/const_colors.dart';

/// The parent logic widget for the order logic
/// which handles the order steps presentation logic
class OrderProgressingWidget extends StatelessWidget {
  const OrderProgressingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      decoration: const BoxDecoration(
        color: ColorsManager.lightTeal,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 26, left: 26, right: 26),
        child: SingleChildScrollView(
          child: Consumer<OrderProvider>(
            builder: (context, orderProvider, child) {
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
            },
          ),
        ),
      ),
    );
  }
}
