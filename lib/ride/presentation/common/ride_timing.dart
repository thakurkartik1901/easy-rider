import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';
import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';
import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RideTiming extends StatelessWidget {
  final DateTime? time;
  final String? label;
  RideTiming({Key? key, this.time, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizationsData labels = context.localizations;
    final isTab = Provider.of<UserNotifier>(context, listen: false).isTab;
    return Row(
      children: [
        MPCHeadingLabel(
          label: label!,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        MPCHeadingLabel(
          label:
              '${DateFormat.jm().format(time!)} - ${DateFormat.MMMMEEEEd().format(time!)}, ${DateFormat.y().format(time!)}',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
          color: AppConstants.textSecondary,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
