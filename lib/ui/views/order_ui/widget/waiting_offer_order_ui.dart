import 'package:bloomdeliveyapp/business_logic/constants/const_colors.dart';
import 'package:bloomdeliveyapp/business_logic/providers/order_provider.dart';
import 'package:bloomdeliveyapp/ui/views/order_ui/widget/cancel_order_button.dart';
import 'package:bloomdeliveyapp/ui/views/order_ui/widget/edit_fare_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widget/general_button.dart';

class WaitingOfferOrderUI extends StatefulWidget {
  const WaitingOfferOrderUI({super.key});

  @override
  State<WaitingOfferOrderUI> createState() => _WaitingOfferOrderUIState();
}

class _WaitingOfferOrderUIState extends State<WaitingOfferOrderUI> {
  late final TextEditingController fareFieldController;

  @override
  void initState() {
    final OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    fareFieldController = TextEditingController(
      text: orderProvider.orderDetails.offeredPrice.toString(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerRight,
          child: CancelOrderButton(),
        ),
        const Text(
          "Looking",
          style: TextStyle(
            color: ColorsManager.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        EditFareContainer(
          fareFieldController: fareFieldController,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18),
          child: GeneralButton(
            title: "Update",
            onTap: () {
              final OrderProvider orderProvider =
                  Provider.of<OrderProvider>(context, listen: false);
              orderProvider.setOfferedPrice(
                double.parse(fareFieldController.text),
              );
            },
          ),
        ),
      ],
    );
  }
}
