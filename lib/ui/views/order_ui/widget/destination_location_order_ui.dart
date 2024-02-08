import 'package:deliveyapp/services/order/cancel_order.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/providers/map_provider.dart';
import '../../../../business_logic/providers/order_provider.dart';
import '../../../../business_logic/utils/enums.dart';
import '../../../widget/destination_field.dart';
import '../../../widget/general_button.dart';
import '../../../widget/locate_on_map_button.dart';

class DestinationLocationOrderUI extends StatelessWidget {
  const DestinationLocationOrderUI({super.key});

  TextEditingController getDestinationFieldController(BuildContext context) {
    MapProvider mapProvider = Provider.of<MapProvider>(
      context,
      listen: false,
    );
    return mapProvider.fieldController;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<MapProvider, bool>(
      selector: (context, mapProvider) => mapProvider.showingMap,
      builder: (context, showingMap, child) {
        if (showingMap) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 00, bottom: 10),
                child: DestinationField(
                  fieldType: FieldType.destination,
                  controller: getDestinationFieldController(context),
                ),
              ),
              GeneralButton(
                title: 'Confirm',
                onTap: () async {
                  MapProvider mapProvider = Provider.of<MapProvider>(
                    context,
                    listen: false,
                  );
                  LatLng selectedDestination = mapProvider.selectedLocation;
                  OrderProvider orderProvider = Provider.of<OrderProvider>(
                    context,
                    listen: false,
                  );
                  orderProvider.addNewDestination(selectedDestination);
                  mapProvider.changeMapSelectionMode(MapSelectionMode.none);
                  mapProvider.createRouteOnMap(
                    pickLocation: orderProvider.orderDetails.pickupLocation!,
                    destinations: orderProvider.orderDetails.destinations,
                  );
                },
              ),
            ],
          );
        }

        final OrderProvider orderProvider = Provider.of<OrderProvider>(context);
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (!didPop) cancelActiveOrder(context);
          },
          child: SafeArea(
            child: Column(
              children: [
                DestinationField(
                  fieldType: FieldType.pickUp,
                  controller: TextEditingController(
                    text:
                        "${orderProvider.orderDetails.pickupLocation?.latitude},${orderProvider.orderDetails.pickupLocation?.longitude}",
                  ),
                ),
                ...orderProvider.orderDetails.destinations
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 10),
                        child: DestinationField(
                          fieldType: FieldType.destination,
                          controller: TextEditingController(
                            text: "${e.latitude},${e.longitude}",
                          ),
                        ),
                      ),
                    )
                    .toList(),
                const Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 10),
                  child: DestinationField(fieldType: FieldType.destination),
                ),
                LocateOnMapButton(onTap: () async {
                  MapProvider mapProvider = Provider.of<MapProvider>(
                    context,
                    listen: false,
                  );
                  mapProvider.changeMapShowState(true);
                  await mapProvider.getUserLocation();
                  mapProvider
                      .changeMapSelectionMode(MapSelectionMode.destination);
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
