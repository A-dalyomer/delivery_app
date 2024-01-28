import 'package:bloomdeliveyapp/business_logic/constants/const_assets.dart';
import 'package:bloomdeliveyapp/business_logic/constants/const_colors.dart';
import 'package:bloomdeliveyapp/business_logic/constants/const_metrics.dart';
import 'package:bloomdeliveyapp/business_logic/providers/map_provider.dart';
import 'package:bloomdeliveyapp/business_logic/providers/order_provider.dart';
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
                    child: AnimatedContainer(
                      height: 100,
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: e == rideType
                              ? ColorsManager.green
                              : Colors.transparent,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            final OrderProvider orderProvider =
                                Provider.of<OrderProvider>(
                              context,
                              listen: false,
                            );
                            orderProvider.setRideType(e);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  e == RideType.truck
                                      ? AppAssets.truckImage
                                      : AppAssets.motorImage,
                                  height: 50,
                                  width: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Selector<OrderProvider, double>(
                                          selector: (_, orderProvider) =>
                                              orderProvider
                                                  .orderDetails.recommendedFare,
                                          builder: (context, recommendedFare,
                                              child) {
                                            return Text(
                                              '${AppMetrics.currency}${(recommendedFare * (e == RideType.truck ? AppMetrics.costPerMeterTruck : AppMetrics.costPerMeterMotor)).toStringAsFixed(2)}',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: ColorsManager.greyText,
                                                fontSize: 14,
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        });
  }
}
