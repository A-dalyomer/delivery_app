import 'package:bloomdeliveyapp/business_logic/providers/map_provider.dart';
import 'package:bloomdeliveyapp/business_logic/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/constants/const_colors.dart';
import '../../../../business_logic/providers/order_provider.dart';
import '../../../widget/destination_field.dart';
import '../../../widget/general_button.dart';

class ConfirmDetailsOrderUI extends StatelessWidget {
  const ConfirmDetailsOrderUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Confirm Details',
                  style: TextStyle(
                    color: ColorsManager.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final MapProvider mapProvider = Provider.of<MapProvider>(
                      context,
                      listen: false,
                    );
                    mapProvider.changeMapSelectionMode(
                      MapSelectionMode.destination,
                    );
                    orderProvider.addMoreDestinations();
                  },
                  child: Text(
                    "Add Stop +",
                    style: TextStyle(
                      color: ColorsManager.green,
                    ),
                  ),
                )
              ],
            ),
            DestinationField(
              fieldType: FieldType.pickUp,
              controller: TextEditingController(
                text:
                    "${orderProvider.orderDetails.pickupLocation?.latitude},${orderProvider.orderDetails.pickupLocation?.longitude}",
              ),
            ),
            SizedBox(height: 16),
            ...orderProvider.orderDetails.destinations
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: DestinationField(
                      fieldType: FieldType.destination,
                      controller: TextEditingController(
                        text: "${e.latitude},${e.longitude}",
                      ),
                      hasDeleteButton: true,
                      onIconTap: () {
                        orderProvider.removeDestination(context, e);
                        final MapProvider mapProvider =
                            Provider.of<MapProvider>(
                          context,
                          listen: false,
                        );
                        mapProvider.createRouteOnMap(
                          pickLocation:
                              orderProvider.orderDetails.pickupLocation!,
                          destinations: orderProvider.orderDetails.destinations,
                        );
                      },
                    ),
                  ),
                )
                .toList(),
            SizedBox(height: 16),
            GeneralButton(
              title: "Confirm",
              onTap: () => orderProvider.confirmOrder(),
            ),
          ],
        );
      },
    );
  }
}
