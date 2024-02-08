import 'package:deliveyapp/business_logic/constants/const_colors.dart';
import 'package:deliveyapp/business_logic/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderBackButton extends StatelessWidget {
  const OrderBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) orderProvider.backInOrderSteps(context);
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: ColorsManager.lightTeal,
              borderRadius: BorderRadius.circular(200),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: ColorsManager.grey.withOpacity(.4),
                )
              ],
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(200),
              child: InkWell(
                borderRadius: BorderRadius.circular(200),
                onTap: () => orderProvider.backInOrderSteps(context),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: ColorsManager.green,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
