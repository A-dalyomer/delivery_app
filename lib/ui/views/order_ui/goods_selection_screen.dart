import 'package:bloomdeliveyapp/business_logic/constants/const_colors.dart';
import 'package:bloomdeliveyapp/business_logic/constants/const_dummy_data.dart';
import 'package:bloomdeliveyapp/ui/widget/general_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// meant to present the available good types and provide the ability to choose one
/// then returns the selected type as a result to the navigation handler
class GoodsSelectionScreen extends StatefulWidget {
  const GoodsSelectionScreen({super.key});

  @override
  State<GoodsSelectionScreen> createState() => _GoodsSelectionScreenState();
}

class _GoodsSelectionScreenState extends State<GoodsSelectionScreen> {
  final List<String> goods = DummyData.goodsData;
  String selectedGood = DummyData.goodsData[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Goods"),
        backgroundColor: ColorsManager.lightTeal,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: goods.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(goods[index]),
                  trailing: Radio(
                    value: goods[index],
                    groupValue: selectedGood,
                    onChanged: (value) => setState(() {
                      selectedGood = value ?? DummyData.goodsData[0];
                    }),
                  ),
                  onTap: () => setState(() => selectedGood = goods[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GeneralButton(
              title: "Confirm",
              onTap: () {
                if (kDebugMode) {
                  print('selected good: $selectedGood');
                }
                Navigator.pop(context, selectedGood);
              },
            ),
          ),
        ],
      ),
    );
  }
}
