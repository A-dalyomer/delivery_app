import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/constants/const_colors.dart';
import '../../../../business_logic/providers/order_provider.dart';

class OrderReceiverSummaryWidget extends StatelessWidget {
  const OrderReceiverSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        OrderProvider orderProvider = Provider.of<OrderProvider>(
          context,
          listen: false,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    orderProvider.orderDetails.receiverInfo?.name ?? 'None',
                    style: const TextStyle(
                      color: ColorsManager.green,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  orderProvider.orderDetails.receiverInfo?.phoneNumber ??
                      'Not provided',
                  style: const TextStyle(
                    color: ColorsManager.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              orderProvider.orderDetails.receiverInfo?.note ??
                  'No Additional notes',
              style: const TextStyle(
                color: ColorsManager.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
