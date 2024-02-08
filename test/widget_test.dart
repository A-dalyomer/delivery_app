import 'package:deliveyapp/business_logic/providers/map_provider.dart';
import 'package:deliveyapp/business_logic/providers/order_provider.dart';
import 'package:deliveyapp/ui/views/map_screen/map_screen.dart';
import 'package:deliveyapp/business_logic/utils/enums.dart';
import 'package:deliveyapp/ui/views/map_screen/widget/map_widget.dart';
import 'package:deliveyapp/ui/views/order_ui/order_progressing_widget.dart';
import 'package:deliveyapp/ui/views/order_ui/widget/order_back_button.dart';
import 'package:deliveyapp/ui/views/order_ui/widget/ride_type_item.dart';
import 'package:deliveyapp/ui/widget/destination_field.dart';
import 'package:deliveyapp/ui/widget/general_button.dart';
import 'package:deliveyapp/ui/widget/general_text_field.dart';
import 'package:deliveyapp/ui/widget/locate_on_map_button.dart';
import 'package:deliveyapp/ui/widget/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('order widget tests', () {
    /// adds the provided widget to the widget tree for testing
    Future<void> pumpMapScreen(WidgetTester tester, Widget widget) async {
      await tester.pumpWidget(
        MaterialApp(home: widget),
      );
    }

    testWidgets('renders MapWidget and OrderProgressingWidget', (tester) async {
      await pumpMapScreen(tester, const DeliveryMapScreen());

      /// validate the initial state widgets presence
      expect(find.byType(MapWidget), findsOneWidget);
      expect(find.byType(OrderProgressingWidget), findsOneWidget);
      expect(find.byType(DestinationField), findsExactly(2));
    });

    testWidgets('switch to Destination selection mode', (tester) async {
      await pumpMapScreen(tester, const DeliveryMapScreen());

      /// since the GPS data can't be provided
      /// drag on map to set a new value for the user pickup location that's different from the destination location
      await tester.drag(find.byType(MapWidget), const Offset(50, 5));

      /// tap on the destination field
      await tester.tap(find.byType(DestinationField).first);
      await tester.pump();

      /// wait extra time to give time for the animation to end
      await tester.pump(const Duration(milliseconds: 200));

      /// validate the change in the active order step to select destination
      expect(find.byType(LocateOnMapButton), findsOneWidget);
      expect(find.byType(MapWidget), findsNothing);

      /// tap on the "Locate on map" button
      await tester.tap(find.byType(LocateOnMapButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      /// validate that the map was built again and in destination selection mode
      expect(find.byType(MapWidget), findsOneWidget);
      expect(find.byType(LocateOnMapButton), findsNothing);
      expect(find.byType(GeneralButton), findsOneWidget);
    });

    testWidgets('switch to receiver info', (tester) async {
      /// set initial values for testing the logic with ui
      await pumpMapScreen(tester, const DeliveryMapScreen());
      final orderProvider = Provider.of<OrderProvider>(
        tester.element(find.byType(MapWidget)),
        listen: false,
      );

      /// initiate the active order with a new object
      orderProvider.setPickupLocation(const LatLng(25, 25));

      /// change active order step to the receiverInfo value
      orderProvider.changeActiveOrderStep(OrderSteps.receiverInfo);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      /// validate widgets presence
      expect(find.text("Receiver Info"), findsOneWidget);
      expect(find.byType(MapWidget), findsOneWidget);
      expect(find.byType(LocateOnMapButton), findsNothing);
      expect(find.byType(GeneralTextField), findsExactly(3));

      /// testing form validation
      await tester.tap(find.byType(GeneralButton));
      await tester.pump();

      /// validate form validation
      expect(find.text("Name must be at least 3 characters"), findsOneWidget);
      expect(find.text("Please provide your phone number"), findsOneWidget);

      /// testing entering receiver info
      await tester.enterText(find.byType(GeneralTextField).at(0), "test name");
      await tester.enterText(
          find.byType(GeneralTextField).at(1), "54198142841");
      await tester.enterText(find.byType(GeneralTextField).at(2), "test note");

      /// save the entered values by pressing the confirm button
      await tester.tap(find.byType(GeneralButton));
      await tester.pump();

      /// validate change of order step to the confirmDetails UI
      expect(find.text("Confirm Details"), findsOneWidget);
    });

    testWidgets('test order back button', (tester) async {
      /// set initial values for testing the logic with ui
      await pumpMapScreen(tester, const DeliveryMapScreen());
      final orderProvider = Provider.of<OrderProvider>(
        tester.element(find.byType(MapWidget)),
        listen: false,
      );
      final mapProvider = Provider.of<MapProvider>(
        tester.element(find.byType(MapWidget)),
        listen: false,
      );
      mapProvider.changeMapSelectionMode(MapSelectionMode.none);
      await tester.pump();

      /// initiate the active order with a new object
      orderProvider.setPickupLocation(const LatLng(25, 25));

      /// change active order step to the confirmDetails value
      orderProvider.changeActiveOrderStep(OrderSteps.confirmDetails);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      /// test tap the back button
      await tester.tap(find.byType(OrderBackButton));
      await tester.pump();

      /// did go back one step
      expect(find.text("Receiver Info"), findsOneWidget);

      /// test second use case
      /// where the back button cancels the current order
      await tester.tap(find.byType(OrderBackButton));
      await tester.pump();
      await tester.tap(find.byType(OrderBackButton));
      await tester.pump();

      /// back to the initial map and order states
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('test ride type selection', (tester) async {
      /// set initial values for testing the logic with ui
      await pumpMapScreen(tester, const DeliveryMapScreen());
      final orderProvider = Provider.of<OrderProvider>(
        tester.element(find.byType(MapWidget)),
        listen: false,
      );
      final mapProvider = Provider.of<MapProvider>(
        tester.element(find.byType(MapWidget)),
        listen: false,
      );
      mapProvider.changeMapSelectionMode(MapSelectionMode.none);
      await tester.pump();

      /// initiate the active order with a new object
      orderProvider.setPickupLocation(const LatLng(25, 25));

      /// change active order step to the rideNow value
      orderProvider.changeActiveOrderStep(OrderSteps.rideNow);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      /// validate the initial value of the selected ride type
      expect(orderProvider.orderDetails.rideType == RideType.motor, isTrue);

      /// tap the non selected ride type
      await tester.tap(find.byType(RideTypeItem).last);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      /// validate the new value of the ride type in the order
      expect(orderProvider.orderDetails.rideType == RideType.truck, isTrue);
    });

    testWidgets('test ride offer fare change', (tester) async {
      /// set initial values for testing the logic with ui
      await pumpMapScreen(tester, const DeliveryMapScreen());
      final orderProvider = Provider.of<OrderProvider>(
        tester.element(find.byType(MapWidget)),
        listen: false,
      );
      await tester.pump();

      /// change active order step to the waitingOffer value
      orderProvider.setPickupLocation(const LatLng(25, 25));
      orderProvider.changeActiveOrderStep(OrderSteps.waitingOffer);
      orderProvider.setOfferedPrice(200);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      /// validate widgets existence
      expect(find.text("Cancel"), findsOneWidget);
      expect(find.text("Looking"), findsOneWidget);
      expect(find.byType(SecondaryButton), findsExactly(2));

      /// process the text field controller into the test
      Finder textFieldFinder = find.byType(TextField);
      TextEditingController? controller =
          (tester.widget(textFieldFinder.first) as TextField).controller;
      String textFieldValue = controller!.text;

      /// validate the text field value
      expect(textFieldValue.isNotEmpty, isTrue);
      expect(textFieldValue == "200.0", isTrue);

      /// tap the add "+10" button
      await tester.tap(find.byType(SecondaryButton).last);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      /// check if the text value in the text field has changed accordingly
      expect(controller.text == "210.0", isTrue);

      /// enter a value to the text field through the tester
      await tester.enterText(find.byType(TextField).first, "500.0");

      /// save the new offered fare
      await tester.tap(find.byType(GeneralButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      /// validate the new offered price that was entered from the text field
      expect(orderProvider.orderDetails.offeredPrice == 500.0, isTrue);
    });

    testWidgets('test cancel order', (tester) async {
      /// set initial values for testing the logic with ui
      await pumpMapScreen(tester, const DeliveryMapScreen());
      final orderProvider = Provider.of<OrderProvider>(
        tester.element(find.byType(MapWidget)),
        listen: false,
      );
      await tester.pump();

      /// change active order step to the waitingOffer value
      orderProvider.setPickupLocation(const LatLng(25, 25));
      orderProvider.changeActiveOrderStep(OrderSteps.waitingOffer);

      /// set fixed new value for offered price
      orderProvider.setOfferedPrice(200);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      /// check for cancel button existence and tap it
      expect(find.text("Cancel"), findsOneWidget);
      await tester.tap(find.text("Cancel"));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      /// validate that the order got canceled properly
      expect(
        orderProvider.activeStep == OrderSteps.pickingPickupLocation,
        isTrue,
      );
      expect(
        orderProvider.orderDetails.pickupLocation == null,
        isTrue,
      );
    });
  });
}
