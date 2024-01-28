import 'package:bloomdeliveyapp/business_logic/constants/const_colors.dart';
import 'package:bloomdeliveyapp/business_logic/providers/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetLocationButton extends StatelessWidget {
  const GetLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final MapProvider mapProvider =
        Provider.of<MapProvider>(context, listen: false);
    return Padding(
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
            onTap: () => mapProvider.getUserLocation(),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(
                Icons.my_location_outlined,
                color: ColorsManager.green,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
