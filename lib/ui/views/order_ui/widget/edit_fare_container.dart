import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/constants/const_colors.dart';
import '../../../../business_logic/providers/order_provider.dart';
import '../../../widget/secondary_button.dart';

class EditFareContainer extends StatelessWidget {
  const EditFareContainer({super.key, required this.fareFieldController});
  final TextEditingController fareFieldController;

  void editFareWithValue({
    required BuildContext context,
    required double newValue,
  }) {
    final OrderProvider orderProvider = Provider.of<OrderProvider>(
      context,
      listen: false,
    );
    fareFieldController.text = newValue.toString();
    orderProvider.setOfferedPrice(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<OrderProvider, double>(
        selector: (_, orderProvider) => orderProvider.orderDetails.offeredPrice,
        builder: (context, offeredPrice, child) {
          return Column(
            children: [
              Text(
                "Offered ride fare: \$$offeredPrice",
                style: const TextStyle(
                  color: ColorsManager.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Current Fare",
                style: TextStyle(
                  color: ColorsManager.black,
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SecondaryButton(
                    title: "-10",
                    color: ColorsManager.grey,
                    onTap: () => editFareWithValue(
                      context: context,
                      newValue: offeredPrice - 10,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      controller: fareFieldController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorsManager.lightTeal,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SecondaryButton(
                    title: "+10",
                    onTap: () => editFareWithValue(
                      context: context,
                      newValue: offeredPrice + 10,
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
