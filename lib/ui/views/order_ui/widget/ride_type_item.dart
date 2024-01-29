import 'package:bloomdeliveyapp/business_logic/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/constants/const_assets.dart';
import '../../../../business_logic/constants/const_colors.dart';
import '../../../../business_logic/constants/const_metrics.dart';
import '../../../../business_logic/providers/order_provider.dart';

class RideTypeItem extends StatelessWidget {
  const RideTypeItem(
      {super.key,
      required this.isSelected,
      required this.rideType,
      required this.onTap,
      p});
  final bool isSelected;
  final RideType rideType;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 100,
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? ColorsManager.green : Colors.transparent,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  rideType == RideType.truck
                      ? AppAssets.truckImage
                      : AppAssets.motorImage,
                  height: 50,
                  width: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rideType.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Selector<OrderProvider, double>(
                          selector: (_, orderProvider) =>
                              orderProvider.orderDetails.recommendedFare,
                          builder: (context, recommendedFare, child) {
                            return Text(
                              '${AppMetrics.currency}${(recommendedFare * (rideType == RideType.truck ? AppMetrics.costPerMeterTruck : AppMetrics.costPerMeterMotor)).toStringAsFixed(2)}',
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
    );
  }
}
