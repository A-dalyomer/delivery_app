import 'package:bloomdeliveyapp/business_logic/constants/const_metrics.dart';
import 'package:flutter/material.dart';

import '../../../../business_logic/constants/const_colors.dart';
import '../../../widget/close_button.dart';
import '../../../widget/general_button.dart';
import 'order_detail_widget.dart';

class SelectFairDialog extends StatelessWidget {
  const SelectFairDialog({
    super.key,
    required this.textEditingController,
    required this.onAccepted,
    required this.recommendedFare,
  });
  final TextEditingController textEditingController;
  final VoidCallback onAccepted;
  final String recommendedFare;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).viewInsets,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 22,
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CloseWidgetButton(),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorsManager.lightTeal,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const OrderDetailWidget(
                          title: "Moto Ride",
                          value: "Single Person Zip Rides",
                          fontSize: 18,
                        ),
                        const SizedBox(height: 16),
                        const OrderDetailWidget(
                          title: "Supported Vehicles",
                          value: "Honda",
                          fontSize: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Recommended Fare",
                              style: TextStyle(
                                color: ColorsManager.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              recommendedFare,
                              style: const TextStyle(
                                color: ColorsManager.lightGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: ColorsManager.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4,
                                      color:
                                          ColorsManager.grey.withOpacity(0.6)),
                                ]),
                            child: TextField(
                              controller: textEditingController,
                              decoration: const InputDecoration(
                                prefixIconConstraints:
                                    BoxConstraints(minHeight: 20),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    AppMetrics.currency,
                                    style: TextStyle(
                                      color: ColorsManager.green,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        GeneralButton(
                          title: "Create Request",
                          onTap: () {
                            Navigator.pop(context);
                            onAccepted();
                          },
                        ),
                      ],
                    ),
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
