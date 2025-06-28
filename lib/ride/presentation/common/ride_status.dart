import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';

import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';
import 'package:easy_rider/ride/model/ride.dart';
import 'package:flutter/material.dart';

class RideStatus extends StatelessWidget {
  final Ride? ride;
  RideStatus(this.ride, {Key? key}) : super(key: key);

  final ValueNotifier<bool> enableSaveButton = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final AppLocalizationsData labels = context.localizations;

    return Row(
      children: [
        MPCHeadingLabel(
          label: labels.ride.status,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        MPCHeadingLabel(
          label: ride != null ? ride!.getStatus(labels) : '',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
          color: ride != null && ride!.isCompleted(labels)
              ? AppConstants.onlineColor
              : AppConstants.errorColor,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
