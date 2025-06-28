import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';
import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:easy_rider/ride/model/ride.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideLocation extends StatelessWidget {
  final Ride? ride;
  RideLocation(this.ride, {Key? key}) : super(key: key);

  final ValueNotifier<bool> enableSaveButton = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final AppLocalizationsData labels = context.localizations;
    final isTab = Provider.of<UserNotifier>(context, listen: false).isTab;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2.0),
                  child: Icon(
                    Icons.location_on,
                    size: 15,
                    color: AppConstants.onlineColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 1,
                  height: 42,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(
              width: 3,
            ),
            Expanded(
              child: Text(
                ride?.pickup?.address ?? "",
                style: TextStyle(
                  color: AppConstants.textSecondary,
                  fontSize: isTab ? 17 : 14,
                  fontWeight: FontWeight.w400,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: Icon(
                Icons.location_on,
                size: 15,
                color: AppConstants.errorColor,
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            Expanded(
              child: Text(
                ride?.drop?.address ?? "",
                style: TextStyle(
                  color: AppConstants.textSecondary,
                  fontSize: isTab ? 17 : 14,
                  fontWeight: FontWeight.w400,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
