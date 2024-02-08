import 'package:deliveyapp/business_logic/providers/map_provider.dart';
import 'package:deliveyapp/business_logic/providers/order_provider.dart';
import 'package:deliveyapp/business_logic/utils/enums.dart';
import 'package:deliveyapp/ui/views/map_screen/widget/get_location_button.dart';
import 'package:deliveyapp/ui/views/map_screen/widget/map_widget.dart';
import 'package:deliveyapp/ui/views/order_ui/widget/order_back_button.dart';
import 'package:deliveyapp/ui/widget/destination_field.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../order_ui/order_progressing_widget.dart';

/// A key for accessing the scaffold state from multiple places in the project
final scaffoldKey2 = GlobalKey<ScaffoldState>();

/// The main map screen which provides the main app [Provider]s to their child widgets
/// Mainly includes the following widgets:
/// [MapWidget], [GetLocationButton], [OrderProgressingWidget], [DestinationField] and [OrderBackButton]
class DeliveryMapScreen extends StatefulWidget {
  const DeliveryMapScreen({Key? key}) : super(key: key);
  @override
  DeliveryMapScreenState createState() => DeliveryMapScreenState();
}

class DeliveryMapScreenState extends State<DeliveryMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey2,
      drawer: const Drawer(),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MapProvider()),
          ChangeNotifierProvider(create: (context) => OrderProvider()),
        ],
        builder: (context, child) {
          return Consumer<MapProvider>(
            builder:
                (BuildContext context, MapProvider mapProvider, Widget? child) {
              return Stack(
                children: [
                  Column(children: [
                    Flexible(
                      child: AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        child: mapProvider.showingMap
                            ? Stack(children: [
                                MapWidget(mapProvider: mapProvider),
                                const Align(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  child: GetLocationButton(),
                                ),
                              ])
                            : const SizedBox.shrink(),
                      ),
                    ),
                    const AnimatedSize(
                      duration: Duration(milliseconds: 200),
                      child: OrderProgressingWidget(),
                    ),
                  ]),
                  if (mapProvider.mapSelectionMode == MapSelectionMode.pickup &&
                      mapProvider.showingMap)
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 10,
                      left: 10,
                      right: 10,
                      child: DestinationField(
                        fieldType: FieldType.pickUp,
                        controller: mapProvider.fieldController,
                        hasDrawerIcon: true,
                        isEditable: true,
                        onSubmitted: (text) {
                          List<double> positions = text
                              .split(',')
                              .map((e) => double.parse(e))
                              .toList();
                          LatLng location =
                              LatLng(positions.first, positions.last);
                          mapProvider.animateCameraToPosition(location);
                          mapProvider.setCurrentSelectedLocation(location);
                        },
                      ),
                    )
                  else if (mapProvider.showingMap)
                    const OrderBackButton(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
