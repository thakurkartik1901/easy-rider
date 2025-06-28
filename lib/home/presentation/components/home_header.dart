import 'package:easy_rider/auth/application/auth_notifier.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';
import 'package:easy_rider/core/presentation/routes/app_routes.dart';
import 'package:easy_rider/core/presentation/widgets/logo/app_logo.dart';
import 'package:easy_rider/home/presentation/helper/app_helper.dart';
import 'package:easy_rider/language/presentation/language_bottomsheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizationsData labels = context.localizations;
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Applogo(),
          PopupMenuButton(
            onSelected: (value) async {
              if (value == "/tnc") {
                await openTnC(context, labels);
              } else if (value == "/language") {
                LanguageBottomsheet.openBottonSheet(context);
              } else if (value == "/logout") {
                openLogout(context, labels);
              }
            },
            itemBuilder: (BuildContext bc) {
              return [
                // PopupMenuItem(
                //   value: '/tnc',
                //   child: Text("T&C"),
                // ),
                PopupMenuItem(
                  value: '/language',
                  child: Text(labels.home.language),
                ),
                PopupMenuItem(
                  value: '/logout',
                  child: Text(labels.logout.logout),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }

  Future<void> openTnC(
    BuildContext context,
    AppLocalizationsData labels,
  ) async {
    const url = "https://company.com/privacy-policy/";

    if (kIsWeb) {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } else {
      Navigator.pushNamed(
        context,
        AppRoutes.webScreen,
        arguments: {'title': labels.about.privacyPolicy, 'url': url},
      );
    }
  }

  void openLogout(BuildContext context, AppLocalizationsData labels) {
    AppHelper.openBottonSheet(
      context,
      heading: labels.logout.heading,
      descritpion: labels.logout.descritpion,
      image: 'assets/images/peep-logout.png',
      buttonLabel: labels.logout.logout,
      onPressed: () async {
        Provider.of<AuthNotifier>(
          context,
          listen: false,
        ).clearCredentialsStorage().then((isLoggedOut) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.splashScreen,
          );
        });
      },
    );
  }
}
