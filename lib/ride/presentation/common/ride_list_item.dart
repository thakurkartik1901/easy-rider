import 'package:easy_rider/core/application/loader_notifier.dart';
import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';

import 'package:easy_rider/core/presentation/widgets/buttons/mpc_icon_label_button.dart';
import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:easy_rider/ride/application/ride_notifier.dart';
import 'package:easy_rider/ride/model/ride.dart';
import 'package:easy_rider/ride/presentation/common/ride_location.dart';
import 'package:easy_rider/ride/presentation/common/ride_status.dart';
import 'package:easy_rider/ride/presentation/common/ride_timing.dart';
import 'package:easy_rider/ride/presentation/helper/start_ride_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RideListItem extends StatelessWidget {
  final Ride? ride;
  final bool? showAction;
  RideListItem(this.ride, {Key? key, this.showAction = true}) : super(key: key);

  final ValueNotifier<bool> enableSaveButton = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final AppLocalizationsData labels = context.localizations;
    final isTab = Provider.of<UserNotifier>(context, listen: false).isTab;
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
        top: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 233, 232, 232),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: body(context, labels, isTab),
    );
  }

  Container body(
      BuildContext context, AppLocalizationsData labels, bool isTab) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ride?.customer?.name ?? '',
            style: TextStyle(
              color: AppConstants.textPrimary,
              fontSize: isTab ? 19 : 16,
              fontWeight: FontWeight.w600,
            ),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          RideLocation(ride),
          const SizedBox(height: 4),
          if (ride!.pickupTime != null)
            RideTiming(
              label: labels.ride.pickupTime,
              time: ride!.pickupTime,
            ),
          if (ride!.startTime != null)
            RideTiming(
              label: labels.ride.startTime,
              time: ride!.startTime,
            ),
          if (ride!.endTime != null)
            RideTiming(
              label: labels.ride.endTime,
              time: ride!.endTime,
            ),
          if (ride != null && ride!.isCompleted(labels))
            const SizedBox(height: 4),
          if (ride != null && !ride!.isCompleted(labels))
            Row(
              children: [
                Expanded(
                  child: MPCIconLabelButton(
                    label: ride != null && ride!.isBeforePickup(labels)
                        ? labels.ride.startTrip
                        : labels.ride.endTrip,
                    padding: 1,
                    fontSize: 14,
                    onTap: () {
                      if (ride != null && ride!.isBeforePickup(labels)) {
                        StartRideBottomsheet.openBottonSheet(
                          context,
                          ride: ride!,
                        );
                      } else {
                        endRide(context);
                      }
                    },
                    labelColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: width * 0.03,
                ),
                InkWell(
                  onTap: () {
                    final lat = ride != null && ride!.isBeforePickup(labels)
                        ? ride?.pickup?.latitude
                        : ride?.drop?.latitude;
                    final lon = ride != null && ride!.isBeforePickup(labels)
                        ? ride?.pickup?.longitude
                        : ride?.drop?.longitude;
                    launchMapsUrl(lat!, lon!);
                  },
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: const CircleAvatar(
                      maxRadius: 21,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.directions,
                        size: 28,
                        color: AppConstants.buttonPrimary,
                      )),
                ),
                Expanded(
                  child: SizedBox(
                    width: width * 0.03,
                  ),
                ),
                InkWell(
                  onTap: () {
                    openDialPad(ride?.customer?.phoneNumber);
                  },
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: const CircleAvatar(
                    maxRadius: 18,
                    backgroundColor: AppConstants.buttonPrimary,
                    child: Icon(
                      Icons.call,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          if (ride != null && ride!.isCompleted(labels)) RideStatus(ride),
        ],
      ),
    );
  }

  void endRide(BuildContext context) {
    context.read<LoaderNotifier>().showLoader();
    context
        .read<RideValueNotifier>()
        .endRide(ride!.id!, context)
        .then((authState) {
      context.read<LoaderNotifier>().hideLoader();
      if (authState == RideStatusUpdate.success) {
        ride?.endTime = DateTime.now();
        ride?.status = 'Completed';
        context.read<RideValueNotifier>().updateRidesData(
              ride!,
            );
      }
    });
  }

  Future<void> openDialPad(String? mobile) async {
    final String url = 'tel:${mobile!}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchMapsUrl(double lat, double lon) async {
    // final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    // final url = "google.navigation:q=$lat,$lon&mode=d";
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$lon&travelmode=driving&dir_action=navigate';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
