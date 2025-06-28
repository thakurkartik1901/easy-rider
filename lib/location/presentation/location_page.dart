import 'package:easy_rider/auth/application/auth_notifier.dart';
import 'package:easy_rider/core/presentation/routes/app_routes.dart';
import 'package:easy_rider/core/presentation/widgets/logo/app_logo.dart';
import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Provider.of<UserNotifier>(context, listen: false).isTab = width > 830;
    navigate(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Center(
              child: SizedBox(
                height: height * 0.22,
                child: const Applogo(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigate(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      // CacheService.put(AppConstants.sharedPreferenceTokenKey, '');
      // Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
      // Navigator.pushReplacementNamed(context, AppRoutes.languageScreen);

      // Navigator.pushReplacementNamed(context, AppRoutes.authenticationScreen);
      // return;
      context.read<AuthNotifier>().isSignedIn(context).then((value) {
        if (value) {
          Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
        } else {
          notAuthenticated(context);
        }
      }).catchError((onError) {
        notAuthenticated(context);
      });
    });
  }

  void notAuthenticated(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.authenticationScreen,
    );
  }
}
