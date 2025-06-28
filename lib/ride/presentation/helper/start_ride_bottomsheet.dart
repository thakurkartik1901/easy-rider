import 'package:easy_rider/ride/model/ride.dart';
import 'package:easy_rider/ride/presentation/helper/start_ride.dart';
import 'package:flutter/material.dart';

class StartRideBottomsheet {
  StartRideBottomsheet._();

  static Future<void> openBottonSheet(
    BuildContext context, {
    required Ride ride,
  }) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: 600),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor:
              MediaQuery.of(context).viewInsets.bottom != 0 ? 0.76 : 0.4,
          child: StartRide(ride),
        );
      },
    );
  }
}
