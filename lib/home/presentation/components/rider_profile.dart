import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';

import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:easy_rider/home/presentation/components/duty_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RiderProfile extends StatefulWidget {
  const RiderProfile({
    super.key,
  });

  @override
  State<RiderProfile> createState() => _RiderProfileState();
}

class _RiderProfileState extends State<RiderProfile> {
  late BuildContext _context;
  late AppLocalizationsData labels;
  bool isLoading = false;
  String? _pic;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    labels = _context.localizations;

    final isTab = Provider.of<UserNotifier>(context, listen: false).isTab;
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: Consumer<UserNotifier>(
        builder: (_, notifier, __) {
          return Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Container(
                  padding: const EdgeInsets.all(
                    5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppConstants.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(80),
                    ),
                    child: notifier.dataUI?.driver?.profilePic != null &&
                            notifier.dataUI?.driver?.profilePic != ""
                        ? Image.network(
                            notifier.dataUI!.driver!.profilePic!,
                            fit: BoxFit.cover,
                            width: 128,
                            height: 128,
                          )
                        : Image.asset(
                            'assets/images/avatar.png',
                            fit: BoxFit.cover,
                            width: 128,
                            height: 128,
                          ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notifier.dataUI?.driver?.name ?? "",
                      style: TextStyle(
                        color: AppConstants.textPrimary,
                        fontSize: isTab ? 17 : 15,
                        fontWeight: FontWeight.w600,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (notifier.dataUI?.driver?.phone != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            notifier.dataUI?.driver?.phone ?? "",
                            style: TextStyle(
                              color: AppConstants.textSecondary,
                              fontSize: isTab ? 17 : 12,
                              fontWeight: FontWeight.w300,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    if (notifier.dataUI?.driver?.licenseNumber != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.car_crash,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            notifier.dataUI?.driver?.licenseNumber ?? "",
                            style: TextStyle(
                              color: AppConstants.textSecondary,
                              fontSize: isTab ? 17 : 12,
                              fontWeight: FontWeight.w300,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const DutyStatus(),
              const SizedBox(
                width: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}
