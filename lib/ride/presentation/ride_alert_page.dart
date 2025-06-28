import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';

import 'package:easy_rider/core/libs/plugins/cache_service.dart';
import 'package:easy_rider/core/presentation/widgets/buttons/mpc_icon_label_button.dart';
import 'package:easy_rider/core/presentation/widgets/components/app_scaffold.dart';
import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';
import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:easy_rider/ride/application/ride_notifier.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RideAlertPage extends StatefulWidget {
  const RideAlertPage({super.key});

  @override
  State<RideAlertPage> createState() => _RideAlertPageState();
}

class _RideAlertPageState extends State<RideAlertPage> {
  late BuildContext _context;
  late AppLocalizationsData labels;
  var _init = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_init) {
      _init = true;
      final rideId = CacheService.get(
        AppConstants.notificationRideKey,
      );
      print("@@@@@RideAlertPage");
      print(rideId);
      Future.microtask(
        () => context.read<RideValueNotifier>().fetchActiveRides().then(
          (value) {
            CacheService.remove(
              AppConstants.notificationRideKey,
            );
          },
        ),
      );
      Future.delayed(const Duration(seconds: 5)).then((value) {
        Navigator.pop(context);
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    labels = _context.localizations;
    final height = MediaQuery.of(context).size.height;
    final isTab = Provider.of<UserNotifier>(context, listen: false).isTab;
    return AppScaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTab ? 30 : 12,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: isTab ? 30 : 12,
            right: isTab ? 30 : 12,
            top: 30,
            bottom: 30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: height * 0.6,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Lottie.asset(
                            height: height * 0.6,
                            width: height * 0.6,
                            'assets/lottie/ripple1.json',
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Lottie.asset(
                            height: height * 0.2,
                            width: height * 0.2,
                            'assets/lottie/belln.json',
                          ),
                        ),
                      ],
                    ),
                  ),
                  MPCHeadingLabel(
                    label: labels.ride.newRide,
                    fontSize: 25,
                    fontFamily: AppConstants.fontFamilyLora,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.textPrimary,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.start,
                    maxLines: 7,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  MPCHeadingLabel(
                    label: labels.ride.receivedNewRide,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppConstants.textSecondary,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.start,
                    maxLines: 7,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              MPCIconLabelButton(
                label: labels.ride.okay,
                onTap: () => {Navigator.pop(context)},
                bgColor: AppConstants.backgroundColor,
                labelColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
