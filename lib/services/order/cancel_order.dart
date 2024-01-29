import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../business_logic/providers/map_provider.dart';
import '../../business_logic/providers/order_provider.dart';

/// cancels the current order and resets both main app providers
void cancelActiveOrder(BuildContext context) {
  final OrderProvider orderProvider = Provider.of<OrderProvider>(
    context,
    listen: false,
  );
  orderProvider.cancelOrder();

  final MapProvider mapProvider = Provider.of<MapProvider>(
    context,
    listen: false,
  );
  mapProvider.reset();
}
