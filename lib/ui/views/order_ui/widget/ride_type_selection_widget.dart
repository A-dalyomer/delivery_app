import 'package:deliveyapp/business_logic/providers/map_provider.dart';
import 'package:deliveyapp/business_logic/providers/order_provider.dart';
import 'package:deliveyapp/ui/views/order_ui/widget/ride_type_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/utils/enums.dart';

class RideTypeSelectionWidget extends StatefulWidget {
  const RideTypeSelectionWidget({super.key});

  @override
  State<RideTypeSelectionWidget> createState() =>
      _RideTypeSelectionWidgetState();
}

class _RideTypeSelectionWidgetState extends State<RideTypeSelectionWidget> {
  void saveOrderRecommendedFare() async {
    final MapProvider mapProvider =
        Provider.of<MapProvider>(context, listen: false);
    final OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    orderProvider.setRecommendedFare(mapProvider.approximateDistance);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      saveOrderRecommendedFare();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<OrderProvider, RideType>(
        selector: (p0, orderProvider) => orderProvider.orderDetails.rideType,
        builder: (context, rideType, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...RideType.values.map((e) {
                return Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RideTypeItem(
                      isSelected: e == rideType,
                      rideType: e,
                      onTap: () {
                        final OrderProvider orderProvider =
                            Provider.of<OrderProvider>(
                          context,
                          listen: false,
                        );
                        orderProvider.setRideType(e);
                      },
                    ),
                  ),
                );
              }),
            ],
          );
        });
  }
}
