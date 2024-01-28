import 'package:bloomdeliveyapp/business_logic/constants/const_colors.dart';
import 'package:bloomdeliveyapp/ui/views/order_ui/widget/order_detail_widget.dart';
import 'package:bloomdeliveyapp/ui/views/order_ui/widget/order_receive_summary_widget.dart';
import 'package:bloomdeliveyapp/ui/views/order_ui/widget/ride_type_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/providers/order_provider.dart';
import '../../../widget/general_button.dart';

class RideNowOrderUI extends StatelessWidget {
  const RideNowOrderUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Available Rides",
          style: TextStyle(
            color: ColorsManager.black,
            fontSize: 16,
          ),
        ),
        RideTypeSelectionWidget(),
        Text(
          "Pickup Contact",
          style: TextStyle(
            color: ColorsManager.greyText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        OrderReceiverSummaryWidget(),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: OrderDetailWidget(
            title: "Paying via",
            iconData: Icons.money,
            value: "Cash",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Selector<OrderProvider, String>(
              selector: (_, orderProvider) =>
                  orderProvider.orderDetails.goodsType,
              builder: (context, value, child) {
                if (value.isEmpty) return SizedBox.shrink();
                return OrderDetailWidget(
                  title: "Goods Type",
                  iconData: Icons.local_shipping_rounded,
                  value: value,
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Selector<OrderProvider, String>(
            selector: (context, orderProvider) =>
                orderProvider.orderDetails.goodsType,
            builder: (context, goodsType, child) {
              return GeneralButton(
                title: goodsType.isEmpty ? "Choose Goods Type" : "Ride Now",
                onTap: () {
                  OrderProvider orderProvider = Provider.of<OrderProvider>(
                    context,
                    listen: false,
                  );
                  orderProvider.rideConfirmation(context);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
