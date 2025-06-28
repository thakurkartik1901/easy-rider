import 'dart:async';

import 'package:easy_rider/auth/application/auth_notifier.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';

import 'package:easy_rider/core/libs/plugins/location/location_service.dart';
import 'package:easy_rider/core/presentation/widgets/components/app_scaffold.dart';
import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:easy_rider/home/presentation/components/home_header.dart';
import 'package:easy_rider/home/presentation/components/rider_profile.dart';
import 'package:easy_rider/home/presentation/helper/app_helper.dart';
import 'package:easy_rider/ride/application/ride_notifier.dart';
import 'package:easy_rider/ride/presentation/ride_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late BuildContext _context;
  late AppLocalizationsData labels;
  bool isTab = false;

  final service = FlutterBackgroundService();
  StreamSubscription<Map<String, dynamic>?>? streamSubscription;
  var _init = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.microtask(() {
      context.read<UserNotifier>().fetchUser().then(
            (value) =>
                AppHelper.checkPackageVersion(context, context.localizations),
          );
      context.read<RideValueNotifier>().fetchActiveRides();
    }); 
  }

  @override
  void didChangeDependencies() {
    if (!_init) {
      _init = true;
      // startLocationService(context: context);
      listenForLocationUpdateStream();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    labels = _context.localizations;
    isTab = Provider.of<UserNotifier>(context, listen: false).isTab;

    return const AppScaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(),
          RiderProfile(),
          Expanded(child: RideSection()),
        ],
      ),
    );
  }
  
  void listenForLocationUpdateStream() {
    LocationService().getCurrentPosition();
    final locationUpdateStream = FlutterBackgroundService().on('update');
    streamSubscription = locationUpdateStream.listen((data) {
      if (mounted && data?['latitude'] != null && data?['longitude'] != null) {
        _context.read<UserNotifier>().syncUserLocation(
              double.parse(data?['latitude'] as String),
              double.parse(data?['longitude'] as String),
            );
      }
    });
  }

  @override
  void dispose() {
    service.isRunning().then((running) {
      if (running) {
        service.invoke("stopService");
      }
    });
    streamSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      LocationService().getCurrentPosition();
    }
  }
}
