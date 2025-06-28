import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';

import 'package:easy_rider/core/presentation/widgets/buttons/mpc_icon_label_button.dart';
import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';
import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

enum Tabs { home, template, plan, language, setting }

class AppHelper {
  AppHelper._();

  static Future<void> openBottonSheet(
    BuildContext context, {
    required String heading,
    required String descritpion,
    String? image,
    required String buttonLabel,
    void Function()? onPressed,
    void Function()? onDismissed,
    String? message,
    bool isDismissible = true,
  }) async {
    final labels = context.localizations;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      constraints: const BoxConstraints(maxWidth: 600),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Provider.of<UserNotifier>(context, listen: false).isTab
                ? 30
                : 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  height: 8,
                  width: 82,
                  margin: const EdgeInsets.all(15.0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        MPCHeadingLabel(
                          label: heading,
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
                          label: descritpion,
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
                        if (message != null)
                          MPCHeadingLabel(
                            label: message,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.start,
                            maxLines: 20,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: [
                  if (isDismissible)
                    Expanded(
                      child: MPCIconLabelButton(
                        label: labels.action.cancel.toUpperCase(),
                        onTap: () => Navigator.of(context).pop(),
                        bgColor: AppConstants.lightGrey,
                        labelColor: AppConstants.textPrimary,
                      ),
                    ),
                  if (isDismissible)
                    SizedBox(
                      width: width * 0.03,
                    ),
                  Expanded(
                    child: MPCIconLabelButton(
                      label: buttonLabel.toUpperCase(),
                      onTap: onPressed,
                      bgColor: AppConstants.primaryColor,
                      labelColor: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * (kIsWeb ? 0.04 : 0.015),
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      if (onDismissed != null) {
        onDismissed();
      }
    });
  }

  static Future<void> checkPackageVersion(
    BuildContext context,
    AppLocalizationsData labels,
  ) async {
    if (kIsWeb) {
      return;
    }
    await PackageInfo.fromPlatform().then((packageInfo) {
      final int currentVersion =
          int.parse(packageInfo.version.replaceAll(".", ""));

      final int minVersion = int.parse(
        (context.read<UserNotifier>().dataUI?.minVersion ?? "1.0.0")
            .replaceAll(".", ""),
      );

      final int maxVersion = int.parse(
        (context.read<UserNotifier>().dataUI?.maxVersion ?? "1.0.0")
            .replaceAll(".", ""),
      );

      if (currentVersion < minVersion) {
        AppHelper.openBottonSheet(
          context,
          heading: labels.appUpdate.heading,
          descritpion: labels.appUpdate.descritpion,
          image: 'assets/images/intro-three.png',
          buttonLabel: labels.action.update,
          onPressed: () {
            if (kIsWeb) {
              return;
            }
          },
          isDismissible: false,
        );
      } else if (currentVersion < maxVersion) {
        AppHelper.openBottonSheet(
          context,
          heading: labels.appUpdate.heading,
          descritpion: labels.appUpdate.descritpion,
          image: 'assets/images/intro-three.png',
          buttonLabel: labels.action.update,
          onPressed: () {
            if (kIsWeb) {
              return;
            }
          },
        );
      }
    });
  }
}
