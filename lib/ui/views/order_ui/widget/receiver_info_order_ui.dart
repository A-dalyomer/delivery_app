import 'package:bloomdeliveyapp/business_logic/constants/const_colors.dart';
import 'package:bloomdeliveyapp/business_logic/models/order/receiver_info_model.dart';
import 'package:bloomdeliveyapp/business_logic/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widget/general_button.dart';
import '../../../widget/general_text_field.dart';

class ReceiverInfoOrderUI extends StatefulWidget {
  const ReceiverInfoOrderUI({super.key});

  @override
  State<ReceiverInfoOrderUI> createState() => _ReceiverInfoOrderUIState();
}

class _ReceiverInfoOrderUIState extends State<ReceiverInfoOrderUI> {
  late final TextEditingController nameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController noteController;

  @override
  void initState() {
    final OrderProvider orderProvider = Provider.of<OrderProvider>(
      context,
      listen: false,
    );
    ReceiverInfo? receiverInfo = orderProvider.orderDetails.receiverInfo;
    nameController = TextEditingController(
      text: receiverInfo?.name,
    );
    phoneNumberController = TextEditingController(
      text: receiverInfo?.phoneNumber,
    );
    noteController = TextEditingController(
      text: receiverInfo?.note,
    );
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    noteController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Receiver Info",
                  style: TextStyle(
                    color: ColorsManager.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.person),
              ],
            ),
          ),
          GeneralTextField(
            controller: nameController,
            inputType: TextInputType.name,
            inputAction: TextInputAction.next,
            hintText: "name",
            validator: (text) {
              if (text != null) {
                if (text.length < 3) {
                  return "Name must be at least 3 characters";
                }
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: GeneralTextField(
              controller: phoneNumberController,
              inputType: TextInputType.number,
              inputAction: TextInputAction.next,
              hintText: "Phone number",
              validator: (text) {
                if (text != null) {
                  if (text.isEmpty) {
                    return "Please provide your phone number";
                  }
                  if (text.length < 6) {
                    return "Please enter your full phone number";
                  }
                }
                return null;
              },
            ),
          ),
          GeneralTextField(
            controller: noteController,
            inputType: TextInputType.text,
            inputAction: TextInputAction.done,
            maxLines: 3,
            hintText: "Additional Info",
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GeneralButton(
              title: 'Continue',
              onTap: () {
                bool validForm = formKey.currentState?.validate() ?? false;
                if (!validForm) return;
                OrderProvider orderProvider = Provider.of<OrderProvider>(
                  context,
                  listen: false,
                );
                orderProvider.setReceiverInfo(
                  name: nameController.text,
                  phoneNumber: phoneNumberController.text,
                  note: noteController.text,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
