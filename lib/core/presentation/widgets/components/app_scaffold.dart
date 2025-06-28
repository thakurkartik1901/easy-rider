import 'dart:async';

import 'package:easy_rider/auth/application/auth_notifier.dart';
import 'package:easy_rider/core/application/loader_notifier.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';
import 'package:easy_rider/home/presentation/helper/app_helper.dart';
import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AppScaffold extends StatefulWidget {
  final Widget body;
  final Color? backgroundColor;
  final bool? insideSafeArea;
  const AppScaffold({
    Key? key,
    required this.body,
    this.backgroundColor,
    this.insideSafeArea = true,
  }) : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  late BuildContext _context;
  late AppLocalizationsData labels;

  @override
  void initState() {
    initConnectivity();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (mounted) {
        _connectivitySubscription =
            _connectivity.onConnectivityChanged.listen(_updateConnectionState);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (_connectivitySubscription != null) {
      _connectivitySubscription?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    labels = _context.localizations;
    final width = MediaQuery.of(context).size.width;
    final margin = width > 835 ? (width - 835) / 2 : 0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: width > 835 ? 835 : width,
        margin: EdgeInsets.only(left: margin.toDouble()),
        color: widget.backgroundColor ?? Colors.white,
        child: Stack(
          children: [
            if (widget.insideSafeArea == true)
              SafeArea(
                child: Center(child: widget.body),
              )
            else
              Center(child: widget.body),
            Consumer<LoaderNotifier>(
              builder: (_, loaderNotifier, __) {
                Widget widget = Container();
                switch (loaderNotifier.loaderState) {
                  case LoaderState.visible:
                    widget = const ColoredBox(
                      color: Colors.white24,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      ),
                    );
                    break;
                  default:
                    widget = Container();
                }
                return widget;
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> initConnectivity() async {
    try {
      await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
  }

  Future<void> _updateConnectionState(List<ConnectivityResult> results) async {
    if (!mounted) {
      return;
    }
    // Use the first result or check if any connection is available
    final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
    
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      _context.read<AuthNotifier>().isSignedIn(_context).then((value) {
        if (value &&
            Provider.of<UserNotifier>(_context, listen: false).dataUI?.driver ==
                null) {
          _context.read<UserNotifier>().fetchUser().then((value) {
            ScaffoldMessenger.of(_context).clearSnackBars();
            AppHelper.checkPackageVersion(_context, labels);
          });
        } else {
          ScaffoldMessenger.of(_context).clearSnackBars();
        }
      }).catchError((onError) {
        ScaffoldMessenger.of(_context).clearSnackBars();
      });
    } else {
      const snackBar = SnackBar(
        content: Text(
          "${'You are offline.\n'}${'Please check your internet connection'} ",
        ),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(25.0),
        duration: Duration(days: 365),
      );
      ScaffoldMessenger.of(_context).showSnackBar(snackBar);
    }
  }
}
