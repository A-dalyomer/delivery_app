import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/map_provider.dart';
import '../providers/order_provider.dart';

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
