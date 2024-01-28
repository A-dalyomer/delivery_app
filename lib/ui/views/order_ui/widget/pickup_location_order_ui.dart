import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/providers/map_provider.dart';
import '../../../../business_logic/providers/order_provider.dart';
import '../../../widget/destination_field.dart';

class PickupLocationOrderUI extends StatelessWidget {
  const PickupLocationOrderUI({super.key});

  @override
  Widget build(BuildContext context) {
    return DestinationField(
      fieldType: FieldType.destination,
      onTap: () async {
        OrderProvider orderProvider = Provider.of<OrderProvider>(
          context,
          listen: false,
        );
        MapProvider mapProvider = Provider.of<MapProvider>(
          context,
          listen: false,
        );
        orderProvider.setPickupLocation(mapProvider.selectedLocation);
        mapProvider.changeMapShowState(false);
      },
    );
  }
}
