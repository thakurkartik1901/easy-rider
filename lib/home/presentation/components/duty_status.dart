import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';
import 'package:easy_rider/core/libs/plugins/location/location_service.dart';
import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';
import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:provider/provider.dart';

class DutyStatus extends StatefulWidget {
  const DutyStatus({super.key});

  @override
  State<DutyStatus> createState() => _DutyStatusState();
}

class _DutyStatusState extends State<DutyStatus> {
  // final service = FlutterBackgroundService();
  late AppLocalizationsData labels;
  @override
  Widget build(BuildContext context) {
    labels = context.localizations;
    return Consumer<UserNotifier>(
      builder: (_, notifier, __) {
        return Column(
          children: [
            Switch(
              value: notifier.dataUI?.cab?.available ?? false,
              activeColor: AppConstants.onlineColor,
              inactiveThumbColor: AppConstants.textSecondary,
              inactiveTrackColor: AppConstants.textSecondaryLight,
              onChanged: (bool value) async {
                print("@@@@@@@");
                print(value);
                if (value) {
                  final position = await LocationService()
                      .getCurrentPosition(context: context);
                  print(position);
                  if (position != null) {
                    notifier.changeDutyStatus(true);
                    // final isRunning = await service.isRunning();
                    // if (!isRunning) {
                    //   service.startService();
                    // }
                  }
                } else {
                  notifier.changeDutyStatus(false);
                }
              },
            ),
            MPCHeadingLabel(
              label: notifier.dataUI?.cab?.available ?? false
                  ? labels.home.online
                  : labels.home.offLine,
              fontSize: 10,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              color: notifier.dataUI?.cab?.available ?? false
                  ? AppConstants.onlineColor
                  : AppConstants.textSecondary,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        );
      },
    );
  }
}
